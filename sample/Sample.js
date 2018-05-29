
if( typeof module !== 'undefined' )
require( 'wstringsextra' );
var _ = wTools;

/**/

var got = _.strExtractStereoStrips( '#abc#' );
var expected = [ '', 'abc', '' ];
console.log( 'strExtractStereoStrips', got );
