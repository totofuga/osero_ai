package Game::Osero::AI::Edge::State;

use base qw(Class::Accessor::Fast);
__PACKAGE__->follow_best_practice();

__PACKAGE__->mk_accessors(
    qw( wing mountain stable c_drop )
);


package Game::Osero::AI::Edge;

1;
