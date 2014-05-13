use strict;
use warnings;

use Test::More;
use Game::Osero::AI::Fixed;
use Game::Osero;

my $osero = Game::Osero->new();

my $pos = Game::Osero::AI::Fixed->evoluate($osero);
is(Game::Osero::AI::Fixed::FIXED_EVOLUTION_VALUES()->[$pos->[0]]->[$pos->[1]], 1);

$osero->drop($pos->[0], $pos->[1]);
$osero->set_turn( $osero->get_rival_turn() );

$pos = Game::Osero::AI::Fixed->evoluate($osero);
is(Game::Osero::AI::Fixed::FIXED_EVOLUTION_VALUES()->[$pos->[0]]->[$pos->[1]], 5);

done_testing();
