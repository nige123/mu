# Do not edit this file - Generated by MiniPerl6
use v5;
use strict;
use MiniPerl6::Perl5::Runtime;
use MiniPerl6::Perl5::Match;
package KindaPerl6::Visitor::EmitPerl5Regex; sub new { shift; bless { @_ }, "KindaPerl6::Visitor::EmitPerl5Regex" } use KindaPerl6::Visitor::EmitPerl5; sub visit { my $self = shift; my $List__ = \@_; my $node; do {  $node = $List__->[0]; [$node] }; $node->emit_perl5() }
;
package Token; sub new { shift; bless { @_ }, "Token" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; my  $regex_source = $self->{regex}->emit_perl5(); my  $source = ('use vars qw($_rule_' . ($self->{name} . ('); ' . ('$_rule_' . ($self->{name} . (' = qr/' . ('(?{ ' . ('local $GLOBAL::_M = [ $GLOBAL::_M, \'create\', pos(), \\$_ ]; ' . ('$GLOBAL::_M2 = $GLOBAL::_M; ' . ('})' . ($regex_source . ('(?{ ' . ('local $GLOBAL::_M = [ $GLOBAL::_M, \'to\', pos() ]; ' . ('$GLOBAL::_M2 = $GLOBAL::_M; ' . ('})' . ('/x; ' . ('sub ' . ($self->{name} . (' { ' . ('local $GLOBAL::_Class = shift; ' . ('/$_rule_' . ($self->{name} . ('/; ' . '}; '))))))))))))))))))))))); return($source) }
;
package Rule::Quantifier; sub new { shift; bless { @_ }, "Rule::Quantifier" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; ($self->{term}->emit_perl5() . ($self->{quant} . $self->{greedy})) }
;
package Rule::Or; sub new { shift; bless { @_ }, "Rule::Or" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; ('(?:' . (Main::join([ map { $_->emit_perl5() } @{ $self->{or} } ], '|') . ')')) }
;
package Rule::Concat; sub new { shift; bless { @_ }, "Rule::Concat" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; ('(?:' . (Main::join([ map { $_->emit_perl5() } @{ $self->{concat} } ], '') . ')')) }
;
package Rule::Subrule; sub new { shift; bless { @_ }, "Rule::Subrule" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; my  $meth = ((1 + index($self->{metasyntax}, '.')) ? ($self->{metasyntax} . ' ... TODO ') : ('\'$\'.$GLOBAL::_Class.\'::_regex_' . ($self->{metasyntax} . '\''))); ('(??{ eval ' . ($meth . (' })' . ('(?{ ' . ('local $GLOBAL::_M = [ $GLOBAL::_M, \'capture\' ]; ' . '})'))))) }
;
package Rule::SubruleNoCapture; sub new { shift; bless { @_ }, "Rule::SubruleNoCapture" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; my  $meth = ((1 + index($self->{metasyntax}, '.')) ? ($self->{metasyntax} . ' ... TODO ') : ('\'$\'.$GLOBAL::_Class.\'::_regex_' . ($self->{metasyntax} . '\''))); ('(??{ eval ' . ($meth . ' })')) }
;
package Rule::Var; sub new { shift; bless { @_ }, "Rule::Var" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; my  $table = { '$' => '$','@' => '$List_','%' => '$Hash_','&' => '$Code_', }; ($table->{$self->{sigil}} . $self->{name}) }
;
package Rule::Constant; sub new { shift; bless { @_ }, "Rule::Constant" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; my  $str = $self->{constant}; do { if (($str eq '\\')) { return('\\\\') } else {  } }; do { if (($str eq '\'')) { return('\\\'') } else {  } }; $str }
;
package Rule::Dot; sub new { shift; bless { @_ }, "Rule::Dot" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; '(?:\n\r?|\r\n?|\X)' }
;
package Rule::SpecialChar; sub new { shift; bless { @_ }, "Rule::SpecialChar" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; my  $char = $self->{char}; do { if (($char eq 'n')) { return('(?:\n\r?|\r\n?)') } else {  } }; do { if (($char eq 'N')) { return('(?:(?!\n\r?|\r\n?)\X)') } else {  } }; do { if (($char eq '\\')) { return('\\\\') } else {  } }; do { if (($char eq '\'')) { return('\\\'') } else {  } }; return(('\\' . $char)) }
;
package Rule::Block; sub new { shift; bless { @_ }, "Rule::Block" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; ('(?{ ' . ('my $ret = ( sub {' . ('do {' . ($self->{closure} . ('}; ' . ('\'974^213\' } ).();' . ('if $ret ne \'974^213\' {' . ('$MATCH.capture( $ret ); ' . ('return $MATCH;' . ('};' . ('1' . ' })'))))))))))) }
;
package Rule::InterpolateVar; sub new { shift; bless { @_ }, "Rule::InterpolateVar" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; Main::say(('# TODO: interpolate var ' . ($self->{var}->emit_perl5() . ''))); die() }
;
package Rule::NamedCapture; sub new { shift; bless { @_ }, "Rule::NamedCapture" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; Main::say(('# TODO: named capture ' . ($self->{ident} . (' := ' . ($self->{rule}->emit_perl5() . ''))))); die() }
;
package Rule::Before; sub new { shift; bless { @_ }, "Rule::Before" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; ('(?=' . ($self->{rule}->emit_perl5() . ')')) }
;
package Rule::NotBefore; sub new { shift; bless { @_ }, "Rule::NotBefore" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; ('(?!' . ($self->{rule}->emit_perl5() . ')')) }
;
package Rule::NegateCharClass; sub new { shift; bless { @_ }, "Rule::NegateCharClass" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; Main::say('TODO NegateCharClass'); die() }
;
package Rule::CharClass; sub new { shift; bless { @_ }, "Rule::CharClass" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; Main::say('TODO CharClass'); die() }
;
package Rule::Capture; sub new { shift; bless { @_ }, "Rule::Capture" } sub emit_perl5 { my $self = shift; my $List__ = \@_; do { [] }; Main::say('TODO RuleCapture'); die() }
;
1;
