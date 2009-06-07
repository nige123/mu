role ReadonlyWrapper {
    has $.value;
    method FETCH() {
        (|$!value);
    }
    method STORE($value) {
        ::Exception.new.throw;
    }
}

role Signature {
    has $.positionals;
    has $.other;
    method ACCEPTS(\$capture) {
        $.positionals.elems == $capture.elems;
    }
    method BIND(\$capture,$scope) {
        my $i = 0;
        my sub BIND_positional($pos) {
            if &infix:<<<>>:(int,int)($i,$capture.elems) {
                $pos.BIND($scope,$capture.positional($i.FETCH));
            } else {
                $pos.BIND_with_default($scope);
            }
            $i = &infix:<+>:(int,int)($i.FETCH,1);
        }
        map(&BIND_positional,self.positionals);
        my sub BIND_other($other) {
            $other.BIND($scope,$capture);
        }
        map(&BIND_other,self.other);
    }
    method BUILDALL() {
        self.positionals = ::Array.new;
        self.other = ::Array.new;
    }
}
role Param {
    has $.name;
    has $.default_value;
    method BIND_with_default($scope) {
        my $default_value = self.default_value;
        self.BIND($scope,$default_value.());
    }
}
role Positional {
    Positional.^compose_role(::Param);
    method register($sig) {
        $sig.positionals.push((|self));
    }
}
role RefParam {
    RefParam.^compose_role(::Positional);
    method BIND($scope,$arg) {
        $scope.{self.name.FETCH} := $arg;
    }
}
role ReadonlyParam {
    ReadonlyParam.^compose_role(::Positional);
    method BIND($scope,$arg) {
        my $wrapper = ReadonlyWrapper.new;
        $wrapper.value = $arg;
        $wrapper.^!is_container = 1;
        $wrapper.FETCH;
        $scope.{self.name.FETCH} := (|$wrapper);
    }
}
role WholeCaptureParam {
    WholeCaptureParam.^compose_role(::Param);
    method BIND($scope,$capture) {
        $scope.{self.name.FETCH} = $capture;
    }
    method register($sig) {
        $sig.other.push((|self));
    }
}

$LexicalPrelude.{'WholeCaptureParam'} := ::WholeCaptureParam;
$LexicalPrelude.{'ReadonlyParam'} := ::ReadonlyParam;
$LexicalPrelude.{'RefParam'} := ::RefParam;
$LexicalPrelude.{'Signature'} := ::Signature;

