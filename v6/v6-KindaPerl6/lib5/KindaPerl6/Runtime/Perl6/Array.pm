{

    package Array;

    # Do not edit this file - Perl 5 generated by KindaPerl6
    use v5;
    use strict;
    no strict 'vars';
    use constant KP6_DISABLE_INSECURE_CODE => 0;
    use KindaPerl6::Runtime::Perl5::Runtime;
    my $_MODIFIED;
    BEGIN { $_MODIFIED = {} }

    BEGIN {
        $_ =
          ::DISPATCH( $::Scalar, "new",
            { modified => $_MODIFIED, name => "$_" } );
    }
    do {
        if (
            ::DISPATCH(
                ::DISPATCH(
                    ::DISPATCH( $GLOBAL::Code_VAR_defined, 'APPLY', $::Array ),
                    "true"
                ),
                "p5landish"
            )
          )
        {
        }
        else {
            do {
                ::MODIFIED($::Array);
                $::Array = ::DISPATCH(
                    ::DISPATCH(
                        $::Class, 'new',
                        ::DISPATCH( $::Str, 'new', 'Array' )
                    ),
                    'PROTOTYPE',
                );
              }
        }
    };
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_parent',
        ::DISPATCH( $::Str, 'new', 'Container' )
    );
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'perl' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $v;
                $v =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$v' } )
                  unless defined $v;

                BEGIN {
                    $v =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$v' } );
                }
                my $s;
                $s =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$s' } )
                  unless defined $s;

                BEGIN {
                    $s =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$s' } );
                }
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $self;
                $self =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$self' } )
                  unless defined $self;

                BEGIN {
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } );
                }
                $self = shift;
                my $CAPTURE;
                $CAPTURE =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$CAPTURE' } )
                  unless defined $CAPTURE;

                BEGIN {
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } );
                }
                ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                do {
                    ::MODIFIED($List__);
                    $List__ = ::DISPATCH( $CAPTURE, 'array', );
                };
                $v;
                ::DISPATCH_VAR( $s, 'STORE',
                    ::DISPATCH( $::Str, 'new', '[ ' ) );
                do {
                    for my $v (
                        @{ ::DISPATCH(
                                $GLOBAL::Code_prefix_58__60__64__62_,
                                'APPLY',
                                ::DISPATCH(
                                    $GLOBAL::Code_prefix_58__60__64__62_,
                                    'APPLY', $self
                                )
                              )->{_value}{_array}
                        }
                      )
                    {
                        my $v;
                        $v =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$v' } )
                          unless defined $v;

                        BEGIN {
                            $v =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$v' } );
                        }
                        ::DISPATCH_VAR(
                            $s, 'STORE',
                            ::DISPATCH(
                                $GLOBAL::Code_infix_58__60__126__62_,
                                'APPLY', $s,
                                ::DISPATCH(
                                    $GLOBAL::Code_infix_58__60__126__62_,
                                    'APPLY',
                                    ::DISPATCH( $v, 'perl', ),
                                    ::DISPATCH( $::Str, 'new', ', ' )
                                )
                            )
                        );
                    }
                };
                return (
                    ::DISPATCH(
                        $GLOBAL::Code_infix_58__60__126__62_,
                        'APPLY', $s, ::DISPATCH( $::Str, 'new', ' ]' )
                    )
                );
            }
        )
    );
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'str' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $self;
                $self =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$self' } )
                  unless defined $self;

                BEGIN {
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } );
                }
                $self = shift;
                my $CAPTURE;
                $CAPTURE =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$CAPTURE' } )
                  unless defined $CAPTURE;

                BEGIN {
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } );
                }
                ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                do {
                    ::MODIFIED($List__);
                    $List__ = ::DISPATCH( $CAPTURE, 'array', );
                };
                ::DISPATCH( $self, 'join', ::DISPATCH( $::Str, 'new', ' ' ) );
            }
        )
    );
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'true' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $self;
                $self =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$self' } )
                  unless defined $self;

                BEGIN {
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } );
                }
                $self = shift;
                my $CAPTURE;
                $CAPTURE =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$CAPTURE' } )
                  unless defined $CAPTURE;

                BEGIN {
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } );
                }
                ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                do {
                    ::MODIFIED($List__);
                    $List__ = ::DISPATCH( $CAPTURE, 'array', );
                };
                ::DISPATCH(
                    $GLOBAL::Code_infix_58__60__33__61__62_,
                    'APPLY',
                    ::DISPATCH( $self, 'elems', ),
                    ::DISPATCH( $::Int, 'new', 0 )
                );
            }
        )
    );
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'int' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $self;
                $self =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$self' } )
                  unless defined $self;

                BEGIN {
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } );
                }
                $self = shift;
                my $CAPTURE;
                $CAPTURE =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$CAPTURE' } )
                  unless defined $CAPTURE;

                BEGIN {
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } );
                }
                ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                do {
                    ::MODIFIED($List__);
                    $List__ = ::DISPATCH( $CAPTURE, 'array', );
                };
                ::DISPATCH( $self, 'elems', );
            }
        )
    );
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'array' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $self;
                $self =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$self' } )
                  unless defined $self;

                BEGIN {
                    $self =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$self' } );
                }
                $self = shift;
                my $CAPTURE;
                $CAPTURE =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$CAPTURE' } )
                  unless defined $CAPTURE;

                BEGIN {
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } );
                }
                ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                do {
                    ::MODIFIED($List__);
                    $List__ = ::DISPATCH( $CAPTURE, 'array', );
                };
                $self;
            }
        )
    );
    ::DISPATCH(
        ::DISPATCH( $::Array, 'HOW', ),
        'add_method',
        ::DISPATCH( $::Str, 'new', 'grep' ),
        ::DISPATCH(
            $::Method,
            'new',
            sub {
                my $List_result =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List_result' } );
                my $s;
                $s =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$s' } )
                  unless defined $s;

                BEGIN {
                    $s =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$s' } );
                }
                my $v;
                $v =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$v' } )
                  unless defined $v;

                BEGIN {
                    $v =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$v' } );
                }
                my $List__ =
                  ::DISPATCH( $::Array, 'new',
                    { modified => $_MODIFIED, name => '$List__' } );
                my $Code_test;
                $Code_test =
                  ::DISPATCH( $::Routine, 'new',
                    { modified => $_MODIFIED, name => '$Code_test' } )
                  unless defined $Code_test;

                BEGIN {
                    $Code_test =
                      ::DISPATCH( $::Routine, 'new',
                        { modified => $_MODIFIED, name => '$Code_test' } );
                }
                $self = shift;
                my $CAPTURE;
                $CAPTURE =
                  ::DISPATCH( $::Scalar, 'new',
                    { modified => $_MODIFIED, name => '$CAPTURE' } )
                  unless defined $CAPTURE;

                BEGIN {
                    $CAPTURE =
                      ::DISPATCH( $::Scalar, 'new',
                        { modified => $_MODIFIED, name => '$CAPTURE' } );
                }
                ::DISPATCH_VAR( $CAPTURE, "STORE", ::CAPTURIZE( \@_ ) );
                do {
                    ::MODIFIED($List__);
                    $List__ = ::DISPATCH( $CAPTURE, 'array', );
                };
                do {
                    ::MODIFIED($Code_test);
                    $Code_test =
                      ::DISPATCH( $List__, 'INDEX',
                        ::DISPATCH( $::Int, 'new', 0 ) );
                };
                $List_result;
                $s;
                $v;
                do {
                    for my $v (
                        @{ ::DISPATCH(
                                $GLOBAL::Code_prefix_58__60__64__62_,
                                'APPLY',
                                ::DISPATCH(
                                    $GLOBAL::Code_prefix_58__60__64__62_,
                                    'APPLY', $self
                                )
                              )->{_value}{_array}
                        }
                      )
                    {
                        my $v;
                        $v =
                          ::DISPATCH( $::Scalar, 'new',
                            { modified => $_MODIFIED, name => '$v' } )
                          unless defined $v;

                        BEGIN {
                            $v =
                              ::DISPATCH( $::Scalar, 'new',
                                { modified => $_MODIFIED, name => '$v' } );
                        }
                        do {
                            if (
                                ::DISPATCH(
                                    ::DISPATCH(
                                        ::DISPATCH( $Code_test, 'APPLY', $v ),
                                        "true"
                                    ),
                                    "p5landish"
                                )
                              )
                            {
                                ::DISPATCH( $List_result, 'push', $v );
                            }
                          }
                    }
                };
                return ($List_result);
            }
        )
      )

      ;
    1
}

