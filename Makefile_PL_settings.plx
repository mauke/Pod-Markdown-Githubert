use strict;
use warnings;

return {
    NAME   => 'Pod::Markdown::Githubert',
    AUTHOR => q{Lukas Mai <l.mai@web.de>},

    CONFIGURE_REQUIRES => {},
    BUILD_REQUIRES => {},
    TEST_REQUIRES => {
        'Test2::V0' => 0,
    },
    PREREQ_PM => {
        'Pod::Markdown' => 0,
        'warnings'      => 0,
        'strict'        => 0,
    },

    REPOSITORY => [ github => 'mauke' ],

    #HARNESS_OPTIONS => ['j4'],
};
