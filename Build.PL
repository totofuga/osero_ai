use 5.006;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Game::Osero::AI',
    license             => 'Artistic_2_0',
    dist_author         => q{root <fujita.yoshihiko@gmail.com>},
    dist_version_from   => 'lib/Game/Osero/AI.pm',
    release_status      => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        #'ABC'              => 1.6,
        #'Foo::Bar::Module' => 5.0401,
        'interface' => '0.03',
    },
    add_to_cleanup     => [ 'OseroAI-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
