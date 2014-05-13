package Game::Osero::AI::Edge;

use strict;
use warnings;
use base qw(Class::Accessor::Fast);

__PACKAGE__->follow_best_practice();
__PACKAGE__->mk_accessors(
    qw( black_state_table white_state_table )
);

sub new {
    my $class = shift;


    my $self = $class->SUPER::new(@_);

    $self->set_black_state_table( [] );
    $self->set_white_state_table( [] );
    $self->_calc_state_table([]);

    return $self;
}

sub _calc_state_table {
    my ($self, $edge_data) = @_;

    if ( @$edge_data == 8 ) {
        my $line_index = $self->line_index($edge_data);
        $self->get_black_state_table->[$line_index] 
            = Game::Osero::AI::Edge::State->new($edge_data, Game::Osero::BLACK);

        $self->get_white_state_table->[$line_index] 
            = Game::Osero::AI::Edge::State->new($edge_data, Game::Osero::WHITE);
        return;
    }

    my @store_edge_data = @$edge_data;

    $self->_calc_state_table( [ @store_edge_data, Game::Osero::BLACK] );
    $self->_calc_state_table( [ @store_edge_data, Game::Osero::WHITE] );
    $self->_calc_state_table( [ @store_edge_data, Game::Osero::BLANK] );
}

sub line_index {
    my ($class, $edge_data) = @_;

    return 3 * ( 3 * ( 3 * ( 3 * ( 3 * ( 3 * ( ( 3 * $edge_data->[0] ) +
        $edge_data->[1]) +
        $edge_data->[2]) +
        $edge_data->[3]) +
        $edge_data->[4]) +
        $edge_data->[5]) +
        $edge_data->[6]) +
        $edge_data->[7];
}

package Game::Osero::AI::Edge::State;

use strict;
use warnings;
use base qw(Class::Accessor::Fast);

use Game::Osero;

__PACKAGE__->follow_best_practice();
__PACKAGE__->mk_accessors(
    qw( wing mountain stable cdrop )
);

sub new {
    my $class      = shift;
    my $edge_data  = shift;
    my $color      = shift;

    my $self = $class->SUPER::new(@_);
    $self->_initialize($edge_data, $color);

    return $self;
}

sub _initialize {
    my ($self, $edge_data, $color) = @_;

    $self->_calc_stable($edge_data, $color);
    $self->_calc_wing_mountain($edge_data, $color);
}

sub _calc_stable {
    my ($self, $edge_data, $color) = @_;

    my $stable_cnt = 0;
    for ( @$edge_data ) {
        last unless ( $_ == $color );
        ++$stable_cnt
    }

    if ( $stable_cnt != @$edge_data ) {
        for ( reverse @$edge_data ) {
            last unless ( $_ == $color );
            ++$stable_cnt
        }
    }

    $self->set_stable($stable_cnt);
}

sub _calc_wing_mountain {
    my ($self, $edge_data, $color) = @_;

    $self->set_wing(0);
    $self->set_mountain(0);

    # 角がうまっていれば違う
    return unless ( $edge_data->[0] == Game::Osero::BLANK && $edge_data->[7] == Game::Osero::BLANK );

    # すべてのB or Aが自分の色である
    foreach ( 2..5 ) {
        return unless $edge_data->[$_] == $color;
    }

    # ウィング判定
    if ( $edge_data->[1] == $color             && $edge_data->[6] == Game::Osero::BLANK ||
         $edge_data->[1] == Game::Osero::BLANK && $edge_data->[6] == $color ) {

        $self->set_wing(1);

    # 山判定
    } elsif ( $edge_data->[1] == $color && $edge_data->[6] == $color ) {

        $self->set_mountain(1);
    }
}


1;
