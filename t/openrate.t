use strict;
use warnings;

use Test::More;
use Game::Osero;

*N = \&Game::Osero::BLANK;
*B = \&Game::Osero::BLACK;
*W = \&Game::Osero::WHITE;

BEGIN { use_ok('Game::Osero::AI::Openrate'); }

my $osero = new Game::Osero;
$osero->set_board([
    [B(), B(), W(), N(), N(), N(), N(), N()],
    [N(), B(), N(), N(), N(), N(), N(), N()],
    [N(), N(), N(), N(), N(), N(), N(), N()],
    [N(), N(), N(), W(), B(), N(), N(), N()],
    [N(), N(), N(), B(), W(), N(), N(), N()],
    [N(), N(), N(), N(), N(), N(), N(), N()],
    [N(), N(), N(), N(), N(), N(), N(), N()],
    [N(), N(), N(), N(), N(), N(), N(), N()],
]);

$osero->drop_openrate(0, 0);
$osero->drop_openrate(0, 1);
$osero->drop_openrate(0, 2);
$osero->drop_openrate(1, 1);

my $openrate_ai = new_ok('Game::Osero::AI::Openrate');

is($openrate_ai->evaluate($osero, B()), 5);
is($openrate_ai->evaluate($osero, W()), -5);

done_testing();
