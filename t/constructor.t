use strict;
use warnings;
use Test::More tests => 62; 

## use the Element constructor to create an element 
## for each type of element, and make sure that they're 
## available in the record afterwards 

use_ok( 'DublinCore::Record' );
use_ok( 'DublinCore::Element' );

my $record = DublinCore::Record->new();

foreach my $element ( @DublinCore::Record::VALID_ELEMENTS ) {
    my $e = DublinCore::Element->new( {
        name        => $element, 
        qualifier   => "$element-qualifier",
        content     => "$element-content",
        language    => "$element-language",
        scheme      => "$element-scheme"
    } );
    $record->add($e);
}

foreach my $element ( @DublinCore::Record::VALID_ELEMENTS ) {
    my $e = $record->$element();
    foreach my $attrib ( qw( qualifier content language scheme ) ) {
        is( $e->$attrib(), "$element-$attrib", "$element : $attrib" ); 
    }
}
