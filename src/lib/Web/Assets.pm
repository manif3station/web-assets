package Web::Assets;

use Dancer2 appname => 'Web';

hook before => sub {
    var assets => {
        meta => [],
        link => [],
        js   => [],
    };
};

sub stringify_attrs {
    my ( $class, %attrs ) = @_;
    my @parts = ();
    while ( my ( $k, $v ) = each %attrs ) {
        next if !defined $k || $k eq '';
        if ( defined $v && $v ne '' ) {
            push @parts, sprintf '%s="%s"', $k, $v;
        }
        else {
            push @parts, $k;
        }
    }
    return join ' ', @parts;
}

sub add_meta {
    my ( $class, %attrs ) = @_;
    push vars->{assets}{meta}->@*, sprintf '<meta %s>',
      $class->stringify_attrs(%attrs)
      if %attrs;
    return;
}

sub add_link {
    my ( $class, %attrs ) = @_;
    push vars->{assets}{'link'}->@*, sprintf '<link %s>',
      $class->stringify_attrs(%attrs)
      if %attrs;
    return;
}

sub add_css {
    my ( $class, $url, %attrs ) = @_;
    $class->add_link( %attrs, rel => 'stylesheet', href => $url ) if $url;
    return;
}

sub add_js {
    my ( $class, $url, %attrs ) = @_;
    $attrs{src} = $url or return;
    push vars->{assets}{js}->@*, sprintf '<script %s></script>',
      $class->stringify_attrs(%attrs);
    return;
}

1;
