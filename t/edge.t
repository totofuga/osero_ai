use Game::Osero::AI::Edge;
use Test::More;

my $state = Game::Osero::AI::Edge::State->new();

$state->set_wing(1);

is($state->get_wing(), 1);

done_testing();
