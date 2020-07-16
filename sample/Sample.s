
if( typeof module !== 'undefined' )
require( 'wstringsextra' );
let _ = wTools;

/**/

var title = _.strCapitalize( _.strToTitle( 'some_test_13_14_this is __13__ __x__' ) );
console.log( title );

/*
Some test 13 14 this is 13 x
*/
