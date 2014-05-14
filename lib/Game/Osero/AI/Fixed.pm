package Game::Osero::AI::Fixed;

use interface 'Game::Osero::AI';
use Game::Osero;

use List::Util;

use constant FIXED_EVOLUTION_VALUES => [
    [ 100, -40, 20,  5,  5, 20, -40, 100 ],
    [ -40, -80, -1, -1, -1, -1, -80, -40 ],
    [  20,  -1,  5,  1,  1,  5,  -1,  20 ],
    [   5,  -1,  1,  0,  0,  1,  -1,   5 ],
    [   5,  -1,  1,  0,  0,  1,  -1,   5 ],
    [  20,  -1,  5,  1,  1,  5,  -1,  20 ],
    [ -40, -80, -1, -1, -1, -1, -80, -40 ],
    [ 100, -40, 20,  5,  5, 20, -40, 100 ],
];

sub evaluate {
    my ($class, $osero) = @_;

    my $value = -999999999;
    my $max_evalute_pos;
    foreach ( @{$osero->get_can_drop_pos()} ){
        
        if ( $value < FIXED_EVOLUTION_VALUES->[$_->[0]]->[$_->[1]] ) {
            $max_evalute_pos = $_;
            $value = FIXED_EVOLUTION_VALUES->[$_->[0]]->[$_->[1]];
        }
    }
    return $max_evalute_pos;
}

1;
