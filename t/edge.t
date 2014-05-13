use Test::More;

use Game::Osero;
use Game::Osero::AI::Edge;

my $state = Game::Osero::AI::Edge::State->new();


subtest 'State' => sub {
    $state->set_wing(1);
    $state->set_mountain(2);
    $state->set_stable(3);
    $state->set_cdrop(4);

    is($state->get_wing(), 1);
    is($state->get_mountain(), 2);
    is($state->get_stable(), 3);
    is($state->get_cdrop(), 4);
};


my $n = Game::Osero::BLANK;
my $b = Game::Osero::BLACK;
my $w = Game::Osero::WHITE;


subtest 'Stable' => sub {
    my $data1 = [
        $b,
        $b,
        $n,
        $n,
        $n,
        $w,
        $w,
        $w,
    ];
    is( Game::Osero::AI::Edge::State->new($data1, $b)->get_stable(), 2);
    is( Game::Osero::AI::Edge::State->new($data1, $w)->get_stable(), 3);

    my $data2 = [
        $w,
        $w,
        $w,
        $w,
        $w,
        $w,
        $w,
        $w,
    ];

    is( Game::Osero::AI::Edge::State->new($data2, $b)->get_stable(), 0);
    is( Game::Osero::AI::Edge::State->new($data2, $w)->get_stable(), 8);

    my $data3 = [
        $n,
        $n,
        $b,
        $w,
        $b,
        $w,
        $w,
        $w,
    ];
    is( Game::Osero::AI::Edge::State->new($data3, $b)->get_stable(), 0);
    is( Game::Osero::AI::Edge::State->new($data3, $w)->get_stable(), 3);

    my $data4 = [
        $b,
        $b,
        $b,
        $w,
        $b,
        $w,
        $b,
        $b,
    ];

    is( Game::Osero::AI::Edge::State->new($data4, $b)->get_stable(), 5);
    is( Game::Osero::AI::Edge::State->new($data4, $w)->get_stable(), 0);
};

subtest 'Wing Mountain' => sub {
    my $data1 = [
        $n,
        $b,
        $b,
        $b,
        $b,
        $b,
        $n,
        $n,
    ];
    is( Game::Osero::AI::Edge::State->new($data1, $b)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data1, $b)->get_wing(),     1);
    is( Game::Osero::AI::Edge::State->new($data1, $w)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data1, $w)->get_wing(),     0);

    my $data2 = [
        $n,
        $b,
        $b,
        $b,
        $b,
        $b,
        $w,
        $n,
    ];
    is( Game::Osero::AI::Edge::State->new($data2, $b)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data2, $b)->get_wing(),     0);
    is( Game::Osero::AI::Edge::State->new($data2, $w)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data2, $w)->get_wing(),     0);
    
    my $data3 = [
        $n,
        $b,
        $b,
        $b,
        $b,
        $b,
        $n,
        $b,
    ];
    is( Game::Osero::AI::Edge::State->new($data3, $b)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data3, $b)->get_wing(),     0);
    is( Game::Osero::AI::Edge::State->new($data3, $w)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data3, $w)->get_wing(),     0);

    my $data4 = [
        $n,
        $w,
        $w,
        $w,
        $w,
        $w,
        $w,
        $n,
    ];
    is( Game::Osero::AI::Edge::State->new($data4, $b)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data4, $b)->get_wing(),     0);
    is( Game::Osero::AI::Edge::State->new($data4, $w)->get_mountain(), 1);
    is( Game::Osero::AI::Edge::State->new($data4, $w)->get_wing(),     0);

    my $data5 = [
        $n,
        $w,
        $w,
        $w,
        $w,
        $w,
        $w,
        $w,
    ];
    is( Game::Osero::AI::Edge::State->new($data5, $b)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data5, $b)->get_wing(),     0);
    is( Game::Osero::AI::Edge::State->new($data5, $w)->get_mountain(), 0);
    is( Game::Osero::AI::Edge::State->new($data5, $w)->get_wing(),     0);
};




done_testing();
