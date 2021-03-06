package Perl6in5::Grammar;
use Perl6in5::Grammar;

my @phases       = qw{ PRE POST ENTER LEAVE KEEP UNDO FIRST START CONTROL
                     LAST BEGIN END INIT CHECK UNITCHECK CATCH NEXT };
my @compUnits    = ( @phases, 'do' );
my @lcPhases     = map lc($_), @phases;
my @blkTypes     = qw{ method submethod sub regex token rule
                     macro module class package grammar};
my @bareFuncs    = qw{ use no say };
my @blkDecls     = qw{ module class grammar role };
my @blkNumbers   = qw{ multi proto only };
my @scopes       = qw{ my our state };
my @sigils       = qw{ $^ $? $ @@ @ % & };

pattern program {
        panic( pkgDecl, "Input file is Perl 5, not Perl 6!" )
        - opt( usev6 - _stmtTrm )
        . opt( stmtList ) - eoi
};

pattern pkgDecl {
        lit('package') + id - _stmtTrm;
};

pattern usev6 {
        lit('use') + lits(qw{ v6 Perl-6 })
        | lit('module') + opt(lit('Main'))
        | lits(qw{ class v6.0.0 v6 6 })
};

pattern id {
        match( qr|^([A-Za-z_]\w*)|s )
};

pattern bareInt {
        match( qr|^(\d+)|s )
};

#rule rx {
#        rx_prmbl . first( map( rx_delims_same( $_ ), qw{ `~!@#$%^&*() }
#};
#
#lrule rx_delims_same {
#        $_[1] . rx_subj . $_[1] . opt( rx_target . $_[1] )
#};

pattern sVari {
        lits( @sigils ) . id
};

pattern commalist {
        plus( - ',' - nothing) . opt( $_[1] . opt( $_[0] ) )
};

pattern _stmt {
        opt( _stmtTrm )
            - ( block . blkTrm
                ^ _nbexpr . _stmtTrm )
};

pattern stmtList {
        star( _stmt ) . opt( expr )
};

pattern _stmtTrm {
        plus( - ';' )
};

pattern blkTrm {
        lit( "\n" ) . opt( _stmtTrm ) ^ _stmtTrm
};

pattern bareString {
        #w('""',star(unmore('"'))) | w("''",star(unmore("'") . id))
};

pattern _nbexpr {
        one(
            panic( pkgDecl, "Can't declare a non-block package")
            , func_call
            , _base
#            , op_numaddt
            , declareAssign
            , impor
            , blkTrait )
};

pattern func_call {
        lit('say') . opt( ws . expr )
};

pattern impor {
        keywords( qw{ no use require module class } ) + id . opt( ws . expr )
};

pattern series {
        my ($pat,$sep,$count) = @_;
        $count ||= 1;
        $pat = $pat . $sep . $pat for (1..($count-1));
};

pattern compose {
        my ($init,$pat,$count) = @_;
        $count ||= 1;
        $init = $count->($init) for (1..$count);
};

pattern block {
        iff( match( qr/^[^;}]+(?:\(.*\))?\s+{/s ) )
        . ( control_protasis_apodosis( keywords( qw{ if unless } ) )
            . star( - control_protasis_apodosis( lit('elsif') ) )
            . opt( - lit('else') - blkBare )
        ^ control_protasis_apodosis( keywords( qw{ while until } ) )
        ^ opt( blkPrmbl - nothing ) . blkBare
        ^ lit('try') + blkBare . opt( + lit('finally') + blkBare )
        ^ control_protasis_apodosis( lit('repeat') + keywords( qw{ while until } )
            . opt( ws . arrowCondResult ) )
        ^ control_apodosis( lit('repeat') . opt( ws . arrowCondResult ) )
            + keywords( qw{ while until } ) + ow( '()', expr )
        ^ control_apodosis( lit('loop') . opt( ws
            . w( '()', - expr - ';' - expr - ';' - expr - opt( ';' ) - nothing) ) )
        ^ control_apodosis( keywords( 'do', 'given', 'when' ) )
        ^ forBuilder( opt( '<' ) . lit('->') + blkPrms )
        ^ forBuilder( lit('->') + blkPrms( isRwAppendix ) )
        ^ opt( scpDecl . ws ) . prmDecl . plus( lit('will')
            + control_apodosis( keywords( @lcPhases ) ) ) )
};

pattern isRwAppendix {
        opt( ws . lit('is') + lit('rw') )
};

pattern forBuilder {
        control_apodosis( lit('for') + expr . opt( ws . $_[1] ) )
};

pattern control_protasis_apodosis {
        control_apodosis( $_[1] + ow( '()', expr ) )
};

pattern control_apodosis {
        $_[1] + blkBare
};

pattern blkBare {
        w( "{}", -( opt( stmtList ) ) )
};

pattern blkPrmbl {
        first(
            blkNumber
            . blkDeclarator
            . blkIdentifier
            . blkVisibility
            . blkPrmsGroup
            . blkTraits
            , compUnit
            , blkLabel
            , arrowDecl )
};

pattern blkNumber {
        opt( keywords( @blkNumbers ) . ws )
};

pattern blkDeclarator {
        # the fact that blkType must be out in front demonstrates that sometimes
        # rules that have potentially overlapping alternatives (clype) may both hit on the
        # longest token matcher, so we have to put the one(s) that should win, earlier.
        ( blkType ^ opt( opt( scpDecl . ws ) . clype . ws ) . blkType ) . ws
};

pattern scpDecl {
        keywords( @scopes )
};

pattern blkType {
        keywords( @blkTypes )
};

pattern blkIdentifier {
        opt( opt( '^' ) . id . ws ) 
};

pattern blkVisibility {
        opt( vsblty . ws )
};

pattern blkPrmsGroup {
        opt( w( '()', - opt( invcDecl ) - nothing ) )
};

pattern invcDecl {
        prmDecl . ':' - opt( blkPrms ) ^ blkPrms
};

pattern prmDecl {
        opt( clype . ws ) . sVari
};

pattern blkPrms {
        my $appendix = $_[1] || nothing;
        prmDecl . $appendix . blkPrmsList( $appendix )
};

pattern blkPrmsList {
        my $appendix = $_[1] || nothing;
        opt( commalist( prmDecl . $appendix ) )
};

pattern blkTraits {
        star( - blkTrait . ws )
};

pattern blkTrait {
        keywords( qw{ is does has } ) + clype + sVari
};

pattern arrowDecl {
        arrowInv . blkPrmsList
};

pattern arrowInv {
        lit( '<-' ) - prmDecl
};

pattern arrowCondResult {
        lit( '->' ) - prmDecl
};

pattern blkRetT {
        clype
};

pattern clype {
        id  # just take any class/type name for now :)
};

pattern blkLabel {
        id . ':';
};

pattern flowCtrl {
        keywords( qw{ do } )
};

pattern compUnit {
        keywords( @compUnits ) . worry( ':' - '{', "colons are for block labels, not special compilation units" )
};

pattern vsblty {
        keywords( qw{ public private } )
};

pattern expr {
        block
        ^ _nbexpr
};

pattern declareAssign {
        opt( scpDecl . ws ) . prmDecl . opt( - '=' - expr )
        ^ keywords( @blkDecls ) + clype
};

# pattern op_numaddt {
        # term . star( -( '+' | '-' ) - term )
# };

# pattern term {
        # factor . star( -( '*' | '/' ) - factor )
# };

# pattern factor {
        # _base . star( - lit('**') - _base )
# };

pattern _base {
        sVari ^ bareInt ^ w( '()', stmtList )
};

    # N  Terms             42 3.14 'eek' "$eek" q/qq["foo"] $x heredoc :!verbose @$array circumfix(anything) self undef rand $magicals [semilist] ((lazy) array composer) { empty/pair/hash } \(capture items) &div:(Int, Int --> Int) $() @() %() &() @@() /abc/ rx:i[abc] s/foo/bar/ typenames func(*) :by(2) :!verbose :(Dog $self:) .meth/.=meth 4,3, sort 2,1 
    # L  Method postfix    .meth .+ .? .* .() .[] .{} .<> .�� .:: .= .^ .: !***
    # L  Autoincrement     ++ --
    # R  Exponentiation    **
    # L  Symbolic unary    ! + - ~ ? | +^ ~^ ?^ \ ^ =
    # L  Multiplicative    * / % +& +< +> ~& ~< ~> ?& div mod
    # L  Additive          + - +| +^ ~| ~^ ?| ?^
    # L  Replication       x xx
    # X  Concatenation     ~
    # X  Junctive and      &
    # X  Junctive or       | ^
    # L  Named unary       sleep abs sin
    # N  Nonchaining infix but does <=> leg cmp .. ..^ ^.. ^..^
    # C  Chaining infix    != == < <= > >= eq ne lt le gt ge ~~ === eqv !eqv
    # X  Tight and         &&
    # X  Tight or          || ^^ // min max
    # L  Conditional       ?? !! ff fff
    # R  Item assignment   = := ::= => += -= **= xx= .=
    # L  Loose unary       true not
    # X  Comma operator    , p5=>
    # X  List infix        Z minmax X X~X X*X XeqvX
    # R  List prefix       : print push say die map substr ... [+] [*] any $ @
    # X  Loose and         and andthen
    # X  Loose or          or xor orelse
    # N  Terminator        ; <==, ==>, <<==, ==>>, {...}, unless, extra ), ], }
