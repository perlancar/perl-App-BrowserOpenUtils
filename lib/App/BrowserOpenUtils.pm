package App::BrowserOpenUtils;

# AUTHORITY
# DATE
# DIST
# VERSION

use 5.010001;
use strict;
use warnings;
use Log::ger;

our %SPEC;

$SPEC{open_browser} = {
    v => 1.1,
    args => {
        urls => {
            'x.name.is_plural' => 1,
            'x.name.singular' => 'url',
            schema => ['array*', of=>'str*'],
            req => 1,
            pos => 0,
            slurpy => 1,
        },
        all => {
            schema => 'true*',
        },
    },
    features => {
        dry_run => 1,
    },
};
sub open_browser {
    require Browser::Open;

    my %args = @_;
    for my $url (@{ $args{urls} }) {
        if ($args{-dry_run}) {
            my $cmd = $args{all} ?
                Browser::Open::open_browser_cmd_all() :
                Browser::Open::open_browser_cmd();
            log_info "[DRY_RUN] Opening %s in browser with: %s ...", $url, $cmd;
        } else {
            log_trace "Opening %s in browser ...", $url;
            Browser::Open::open_browser($url, $args{all});
        }
    }
    [200];
}

1;
# ABSTRACT: Utilities related to Browser::Open

=head1 SYNOPSIS

=head1 DESCRIPTION

This distribution includes several utilities:

#INSERT_EXECS_LIST


=head1 SEE ALSO

L<App::BrowserUtils>
