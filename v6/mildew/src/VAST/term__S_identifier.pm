use MooseX::Declare;
use utf8;
class VAST::term__S_identifier {
    use AST::Helpers;
    method emit_m0ld {
        my $id = $self->{identifier}{TEXT};
        fcall '&'.$id => named_and_positional($self->{args}->emit_m0ld);
    }
}
