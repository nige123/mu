{-# OPTIONS_GHC -Wall -fglasgow-exts -fno-warn-missing-methods -fno-warn-orphans -fno-warn-type-defaults -fno-warn-unused-binds #-}

import Data.Ord
import Data.Set (Set)
import System.Random
import Test.QuickCheck
import Control.Monad.Error
import System.CPUTime
import Control.Parallel.Strategies  
import Data.Monoid
import Text.Printf
import qualified Data.List as List
import qualified Data.Set as Set

newtype Sig = MkSig Int deriving (Show, Eq, Ord)

instance (Ord a, Arbitrary a) => Arbitrary (Set a) where
    arbitrary = fmap Set.fromList arbitrary

instance Arbitrary Sig where
    arbitrary = fmap (MkSig . (`mod` 32768)) arbitrary

sigCompare :: Sig -> Sig -> Ordering
sigCompare sx@(MkSig x) sy@(MkSig y) = case compare x y of
    GT  -> case res `mod` 3 of
        0   -> LT
        1   -> GT
        _   -> EQ
    LT -> case sigCompare sy sx of
        LT  -> GT
        GT  -> LT
        _   -> EQ
    EQ -> EQ
    where
    res = fst . next $ mkStdGen (x * 32768 + y)

dumpCmp :: [Sig] -> String
dumpCmp = concatMap dumpCmp' . List.tails
    where
    dumpCmp' :: [Sig] -> String
    dumpCmp' []     = ""
    dumpCmp' [_]    = ""
    dumpCmp' (x:xs) = (concatMap (\c -> show x ++ " " ++ (show $ x `sigCompare` c) ++ " " ++ show c ++ "\n") xs)

prop_sigCompare :: (Sig, Sig) -> Bool
prop_sigCompare (x, y) = case (sigCompare x y, sigCompare y x) of
    (LT, GT)    -> True
    (GT, LT)    -> True
    (EQ, EQ)    -> True
    _           -> False

prop_dispatch :: Set Sig -> Bool
prop_dispatch xs = case dispatch (Set.toAscList xs) sigCompare of
    ROk winner  -> winsOverRest winner
    _           -> Set.null (Set.filter winsOverRest xs)
    where
    winsOverRest x = Set.null (Set.filter winsOrTiesWithX rest)
        where
        rest                = Set.delete x xs
        winsOrTiesWithX y   = (sigCompare x y) /= GT

data DispatchResult a
    = ROk !a
    | RTied
    | RSpoiled

dispatch :: Eq a => [a] -> (a -> a -> Ordering) -> DispatchResult a
dispatch candlist cmp = dispatch' candlist
    where
    dispatch' []        = RTied
    dispatch' (x:y:zs)  = dispatch' $ case cmp x y of
        GT -> x:zs
        LT -> y:zs
        _  -> zs
    dispatch' [x]
        | all losesToX spoilers = ROk x
        | otherwise             = RSpoiled
        where
        spoilers   = case takeWhile (/= x) candlist of
            []  -> []
            [_] -> []
            xs  -> xs
        losesToX y = case cmp x y of
            GT  -> True
            _   -> False

data Total = Total { tied :: !Int, spoiled :: !Int, okay :: !Int }
    deriving Show

instance Monoid Total where
    mempty = Total 0 0 0
    mappend (Total t1 s1 o1) (Total t2 s2 o2) = Total (t1+t2) (s1+s2) (o1+o2)

classify_dispatches :: Int -> Int -> Int -> String
classify_dispatches seed size count = show (foldl cls mempty runs)
    where
    runs = map (`dispatch` sigCompare) samp
    samp = generate size (mkStdGen seed) (replicateM count (arbitrary :: Gen [Sig]))
    cls total x = case x of
        RTied       -> total{ tied      = succ (tied total) }
        RSpoiled    -> total{ spoiled   = succ (spoiled total) }
        ROk{}       -> total{ okay      = succ (okay total) }

getCPUDuration :: NFData a => a -> IO (a, Integer)
getCPUDuration res = do
    v0  <- getCPUTime
    v1  <- (res `using` rnf) `seq` getCPUTime
    return (res, v1 - v0)

main :: IO ()
main = do
    putStrLn "Testing prop_sigCompare"
    quickCheck prop_sigCompare
    putStrLn "Testing prop_dispatch"
    --check defaultConfig{ configMaxTest = 1000 } prop_dispatch
    sequence_ [quickCheck prop_dispatch | _ <- [1..10]]
    
    let times = 100000
    putStrLn $ "Timing " ++ (show times) ++ " dispatches"
    (res, time') <- getCPUDuration (classify_dispatches 23452 10 times)
    let time = ((fromInteger time') :: Double) / fromInteger 1000000000000
    putStrLn res
    printf "%.2f seconds, %.2f dispatches/sec\n" time (fromIntegral times / time)


