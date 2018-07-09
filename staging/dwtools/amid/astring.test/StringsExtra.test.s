( function _String_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  if( typeof _global_ === 'undefined' || !_global_.wBase )
  {
    let toolsPath = '../../../dwtools/Base.s';
    let toolsExternal = 0;
    try
    {
      toolsPath = require.resolve( toolsPath );
    }
    catch( err )
    {
      toolsExternal = 1;
      require( 'wTools' );
    }
    if( !toolsExternal )
    require( toolsPath );
  }

  var _ = _global_.wTools;

  _.include( 'wTesting' );

}

var _ = _global_.wTools;

// --
//
// --

function strCamelize( test )
{
  test.description = 'converts string to camelcase';
  var got = _.strCamelize( 'a-b_c/d' );
  var expected = 'aBCD';
  test.identical( got,expected );

  test.description = 'string with spaces';
  var got = _.strCamelize( '.test -str_ing /with .spaces' );
  var expected = 'Test StrIng With Spaces';
  test.identical( got,expected );

  test.description = 'string with no spaces';
  var got = _.strCamelize( 'camel.case/string' );
  var expected = 'camelCaseString';
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strCamelize( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strCamelize( 'one','two' );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strCamelize( );
  });

  test.description = 'wrong argument type';
  test.shouldThrowError( function()
  {
    _.strCamelize( 111 );
  });

  test.description = 'wrong argument type';
  test.shouldThrowError( function()
  {
    _.strCamelize( [ ] );
  });

}

//

function strFilenameFor( test )
{

  test.description = 'converts string to camelcase';
  var got = _.strFilenameFor( '"example\\file?name.txt' );
  var expected = '_example_file_name.txt';
  test.identical( got,expected );

  test.description = 'convertion with options';
  var got = _.strFilenameFor({ srcString : '\'example\\file?name.js', 'delimeter':'#' } );
  var expected = '#example#file#name.js';
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strFilenameFor( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( 'one','two','three' );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( );
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( 111 );
  });

  test.description = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strFilenameFor( '"example\\file?name.txt','wrong' );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( () => _.strFilenameFor() );

  test.description = 'too many arguments';
  test.shouldThrowError( () => _.strFilenameFor( 1,1 ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( null ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( undefined ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( {} ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strFilenameFor( [] ) );

}

//

function strHtmlEscape( test )
{

  test.description = 'replaces html escape symbols';
  var got = _.strHtmlEscape( '<&test &text &here>' );
  var expected = '&lt;&amp;test &amp;text &amp;here&gt;';
  test.identical( got,expected );

  test.description = 'replaces html escape symbols from array';
  var got = _.strHtmlEscape( ['&','<'] );
  var expected = '&amp;,&lt;';
  test.identical( got,expected );

  test.description = 'object passed';
  var got = _.strHtmlEscape( {'prop': 'value'} );
  var expected = '[object Object]';
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strHtmlEscape( '' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'nothin replaced';
  var got = _.strHtmlEscape( 'text' );
  var expected = 'text';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strHtmlEscape( 'one','two' );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strHtmlEscape( );
  });

}

//

function strReplaceAll( test )
{

  /* */

  test.description = 'simple replace';
  var got = _.strReplaceAll( 'aabaa','b','c' );
  var expected = 'aacaa';
  test.identical( got,expected );

  test.description = 'simple replace';
  var got = _.strReplaceAll( 'aabaa','aa','zz' );
  var expected = 'zzbzz';
  test.identical( got,expected );

  test.description = 'first two args empty strings';
  var got = _.strReplaceAll( '', '', 'c' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'secong argument is empty string';
  var got = _.strReplaceAll( 'a', '', 'c' );
  var expected = 'a';
  test.identical( got,expected );

  test.description = 'all three args empty strings';
  var got = _.strReplaceAll( '', '', '' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'third arg is empty string ';
  var got = _.strReplaceAll( 'a', 'a', '' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'one argument call';
  var got = _.strReplaceAll( { src : 'gpx', dictionary : { 'x' : 'a' } } );
  var expected = 'gpa';
  test.identical( got,expected );

  test.description = 'two arguments call';
  var got = _.strReplaceAll( 'hello', { 'l' : 'y' } );
  var expected = 'heyyo';
  test.identical( got,expected );

  test.description = 'no occurrences returns origin';
  var got = _.strReplaceAll( 'hello', 'x', 'y' );
  var expected = 'hello';
  test.identical( got,expected );

  test.description = 'empty dictionary';
  var got = _.strReplaceAll( 'hello', { } );
  var expected = 'hello';
  test.identical( got,expected );

  /* special cases */

  test.description = 'empty by empty, empty src';
  var got = _.strReplaceAll( '','','' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'not empty by empty, empty src';
  var got = _.strReplaceAll( '','x','' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'empty by not empty, empty src';
  var got = _.strReplaceAll( '','','x' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'empty by empty, not empty src';
  var got = _.strReplaceAll( 'x','','' );
  var expected = 'x';
  test.identical( got,expected );

  test.description = 'not empty by empty, not empty src';
  var got = _.strReplaceAll( 'x','x','' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'empty by not empty, not empty src';
  var got = _.strReplaceAll( 'x','','x' );
  var expected = 'x';
  test.identical( got,expected );

  test.description = 'repeat';
  var got = _.strReplaceAll( 'ababab','ab','ab' );
  var expected = 'ababab';
  test.identical( got,expected );

  test.description = 'no recursion should happen';
  var got = _.strReplaceAll( 'abcabc',{ abc : 'a', a : 'b' } );
  var expected = 'aa';
  test.identical( got,expected );

  test.description = 'no recursion should happen';
  var got = _.strReplaceAll( 'abcabc',[ [ 'abc', 'a' ], [ 'a', 'b' ] ] );
  var expected = 'aa';
  test.identical( got,expected );

  test.description = 'no recursion should happen';
  var got = _.strReplaceAll( 'abcabc',[ [ 'a', 'b' ], [ 'abc', 'a' ] ] );
  var expected = 'bbcbbc';
  test.identical( got,expected );

  /* */

  test.description = 'regexp';

  var got = _.strReplaceAll( 'aabaa',/b/gm,'c' );
  var expected = 'aacaa';
  test.identical( got,expected );

  var got = _.strReplaceAll( '12345',/[1-3]/gm,'0' );
  var expected = '00045';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpbaac',/a+/gm,'b' );
  var expected = 'gpbbc';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpbgpcgpd',/(gp)+[^bc]$/gm,'x' );
  var expected = 'gpbgpcx';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpa',[ 'a' ], [ 'b' ] );
  var expected = 'gpb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpa',[ /a/ ], [ 'b' ] );
  var expected = 'gpb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpa',[ /a/gm ], [ 'b' ] );
  var expected = 'gpb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpahpb',[ 'a', 'b' ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpahpb',[ /a/gm, /b/gm ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'gpahpb',[ /a/gm, 'b' ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got,expected );

  /* */

  function replaceHell( match, it )
  {
    debugger;
    test.identical( arguments.length, 2 );
    test.identical( match, 'hell' );

    if( it.counter === 0 )
    {
      var expectedIt = Object.create( null );
      expectedIt.match = 'hell';
      expectedIt.range = [ 8,12 ];
      expectedIt.counter = 0;
      expectedIt.input = 'this is hello from hell';
      expectedIt.groups = [];
      test.identical( it, expectedIt );
    }
    else
    {
      var expectedIt = Object.create( null );
      expectedIt.match = 'hell';
      expectedIt.range = [ 19,23 ];
      expectedIt.counter = 1;
      expectedIt.input = 'this is hello from hell';
      expectedIt.groups = [];
      test.identical( it, expectedIt );
    }

    return 'paradise';
  }

  test.description = 'trivial ins:string sub:routine';
  var got = _.strReplaceAll( 'this is hello from hell', 'hell', replaceHell );
  var expected = 'this is paradiseo from paradise';
  test.identical( got,expected );

  test.description = 'trivial ins:regexp sub:routine';
  var got = _.strReplaceAll( 'this is hello from hell', /hell/g, replaceHell );
  var expected = 'this is paradiseo from paradise';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1', '2', '3', '4' );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( );
  });

  test.description = 'first argument is wrong';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( 1, '2','3');
  });

  test.description = 'second argument is wrong';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1', 2, '3');
  });

  test.description = 'third argument is wrong';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1','2', 3);
  });

  test.description = 'second arg is not a Object';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1', 2);
  });

  test.description = 'argument is not a Object';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( '1' );
  });

  test.description = 'wrong type of dictionary value';
  test.shouldThrowError( function()
  {
    _.strReplaceAll( { dst : 'gpx', dictionary : { 'a' : [ 1, 2 ] } } )
  });

  test.shouldThrowError( function()
  {
    _.strReplaceAll( 'gpahpb',[ 'a' ], [ 'c', 'd' ] );
  });

  test.shouldThrowError( function()
  {
    _.strReplaceAll( 'gpahpb',[ 'a', 'b' ], [ 'x' ] );
  });

  test.shouldThrowError( function()
  {
    _.strReplaceAll( 'gpahpb',{ 'a' : [ 'x' ] } );
  });

}

//

function strSorterParse( test )
{
  var src;
  var fields;
  var expected;
  var got;

  /* */

  test.description = 'str without special characters';
  src = 'ab'
  expected = [];
  got = _.strSorterParse( src );

  /* */

  test.description = 'single pair';
  src = 'a>'
  expected = [ [ 'a', 1 ] ];
  got = _.strSorterParse( src );

  /* */

  test.description = 'src only';

  src = 'a>b>'
  expected = [ [ 'a', 1 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a<b<'
  expected = [ [ 'a', 0 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a>b<'
  expected = [ [ 'a', 1 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a<b>'
  expected = [ [ 'a', 0 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a>b>c<d>'
  expected = [ [ 'a', 1 ], [ 'b', 1 ],[ 'c', 0 ], [ 'd', 1 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  src = 'a+b>c-d<'
  expected = [ [ 'a+b', 1 ], [ 'c-d', 0 ] ];
  got = _.strSorterParse( src );
  test.identical( got, expected );

  /* */

  test.description = 'with fields';
  var fields = { a : 'a', b : 'b', 'a+b' : 1, 'c-d' : 1 };

  src = 'a>b>'
  expected = [ [ 'a', 1 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a<b<'
  expected = [ [ 'a', 0 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a>b<'
  expected = [ [ 'a', 1 ], [ 'b', 0 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a<b>'
  expected = [ [ 'a', 0 ], [ 'b', 1 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  src = 'a+b>c-d<'
  expected = [ [ 'a+b', 1 ], [ 'c-d', 0 ] ];
  got = _.strSorterParse( src, fields );
  test.identical( got, expected );

  /* */

  if( !Config.debug )
  return;

  test.description = 'with fields';
  var fields = { a : 'a', b : 'b' };
  src = 'a>b>c>'
  test.shouldThrowError( () => _.strSorterParse( src, fields ) );

  test.description = 'src must be str, fields must be objectLike';
  src = 'a>b';
  fields = [];
  test.shouldThrowError( () => _.strSorterParse( src, fields ) );
}

// --
//
// --

function strMetricFormat( test )
{

  test.description = 'default options';
  var got = _.strMetricFormat( '100m', {} );
  var expected = '100.0 ';
  test.identical( got,expected );

  test.description = 'default options';
  var got = _.strMetricFormat( 0.005 );
  var expected = '5.0 m';
  test.identical( got,expected );

  test.description = 'number to million';
  var got = _.strMetricFormat( 1, { metric : 6 } );
  var expected = '1.0 M';
  test.identical( got,expected );

  test.description = 'metric out of range';
  var got = _.strMetricFormat( 1, { metric : 25 } );
  var expected = '1.0 ';
  test.identical( got,expected );

  test.description = 'fixed : 0';
  var got = _.strMetricFormat( '1300', { fixed : 0 } );
  var expected = '1 k';
  test.identical( got,expected );

  test.description = 'divisor, thousand test';
  var got = _.strMetricFormat( '1000000',{ divisor : 2, thousand:100 } );
  var expected = '1.0 M';
  test.identical( got,expected );

  test.description = 'divisor, thousand,dimensions,metric test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3,metric: 1 } );
  var expected = '10.0 k'
  test.identical( got,expected );

  test.description = 'divisor, thousand,dimensions test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3 } );
  var expected = '10.0 h';
  test.identical( got,expected );

  test.description = 'divisor, thousand,dimensions,fixed test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3, fixed : 0 } );
  var expected = '10 h';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( '1', { fixed : 0 }, '3' );
  });

  test.description = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( [ 1, 2, 3 ] );
  });

  test.description = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( 11, '0' );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strMetricFormat();
  });

  test.description = 'fixed out of range';
  test.shouldThrowError( function()
  {
    _.strMetricFormat( '1300', { fixed : 21 } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( () => _.strMetricFormat() );

  test.description = 'too many arguments';
  test.shouldThrowError( () => _.strMetricFormat( 1,1 ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( null ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( undefined ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( {} ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormat( [] ) );

}

//

function strMetricFormatBytes( test )
{

  test.description = 'zero';
  var got = _.strMetricFormatBytes( 0 );
  var expected = '0.0 b';
  test.identical( got,expected );

  test.description = 'string zero';
  var got = _.strMetricFormatBytes( '0' );
  var expected = '0.0 b';
  test.identical( got,expected );

  test.description = 'string';
  var got = _.strMetricFormatBytes( '1000000' );
  var expected = '976.6 kb';
  test.identical( got,expected );

  test.description = 'default options';
  var got = _.strMetricFormatBytes( 1024 );
  var expected = '1024.0 b';
  test.identical( got,expected );

  test.description = 'default options';
  var got = _.strMetricFormatBytes( 2500 );
  var expected = '2.4 kb';
  test.identical( got,expected );

  test.description = 'fixed';
  var got = _.strMetricFormatBytes( 2500, { fixed : 0 } );
  var expected = '2 kb';
  test.identical( got,expected );

  test.description = 'invalid metric value';
  var got = _.strMetricFormatBytes( 2500 , { metric:4 } );
  var expected = '2500.0 b';
  test.identical( got,expected );

  test.description = 'divisor test';
  var got = _.strMetricFormatBytes( Math.pow(2,32) , { divisor:4, thousand: 1024 } );
  var expected = '4.0 Tb';
  test.identical( got,expected );


  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid first argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes( [ '1', '2', '3' ] );
  });

  test.description = 'invalid second argument type';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes( 0, '0' );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes();
  });

  test.description = 'fixed out of range';
  test.shouldThrowError( function()
  {
    _.strMetricFormatBytes( '1300', { fixed : 22 } );
  });

  test.description = 'not enough arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes() );

  test.description = 'too many arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( 1,1 ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( null ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( undefined ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( {} ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strMetricFormatBytes( [] ) );

}

//

function strToBytes( test )
{

  test.description = 'simple string';
  var got = _.strToBytes( 'abcd' );
  var expected = new Uint8Array ( [ 97, 98, 99, 100 ] );
  test.identical( got,expected );

  test.description = 'escaping';
  var got = _.strToBytes( '\u001bABC\n\t' );
  var expected = new Uint8Array ( [ 27, 65, 66, 67, 10, 9 ] );
  test.identical( got,expected );

  test.description = 'zero length';
  var got = _.strToBytes( '' );
  var expected = new Uint8Array ( [ ] );
  test.identical( got,expected );

  test.description = 'returns the typed-array';
  var got = _.strToBytes( 'abc' );
  var expected = got;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'invalid arguments count';
  test.shouldThrowError( function()
  {
    _.strToBytes( '1', '2' );
  });

  test.description = 'invalid argument type';
  test.shouldThrowError( function()
  {
    _.strToBytes( 0 );
  });

  test.description = 'no arguments';
  test.shouldThrowError( function()
  {
    _.strToBytes();
  });

  test.description = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strToBytes( [  ] );
  } );

  test.description = 'argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strToBytes( 13 );
  } );

  test.description = 'not enough arguments';
  test.shouldThrowError( () => _.strToBytes() );

  test.description = 'too many arguments';
  test.shouldThrowError( () => _.strToBytes( 1,1 ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( null ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( undefined ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( {} ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strToBytes( [] ) );

}

//

function strTimeFormat( test )
{

  test.description = 'simple number';
  var got = _.strTimeFormat( 0 );
  var expected = '0.000 s';
  test.identical( got,expected );

  test.description = 'simple number';
  var got = _.strTimeFormat( 1000 );
  var expected = '1.000 s';
  test.identical( got,expected );

  test.description = 'simple number';
  var got = _.strTimeFormat( 1 );
  var expected = '1.000 ms';
  test.identical( got,expected );

  test.description = 'big number';
  var got = _.strTimeFormat( Math.pow( 4,7 ) );
  var expected = '16.384 s';
  test.identical( got,expected );

  test.description = 'very big number';
  var got = _.strTimeFormat( Math.pow( 13,13 ) );
  var expected = '302.875 Gs';
  test.identical( got,expected );

  // test.description = 'zero';
  // var got = _.strTimeFormat( 0 );
  // var expected = '0.000 ys';
  // test.identical( got,expected );

  test.description = 'from date';
  var d = new Date( 1,2,3 )
  var got = _.strTimeFormat( d );
  var expected = '-2.172 Gs';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'not enough arguments';
  test.shouldThrowError( () => _.strTimeFormat() );

  test.description = 'too many arguments';
  test.shouldThrowError( () => _.strTimeFormat( 1,1 ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( null ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( undefined ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( {} ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( [] ) );

  test.description = 'bad arguments';
  test.shouldThrowError( () => _.strTimeFormat( '24:00' ) );

}

//

function strDifference( test )
{

  test.description = 'returns the string';
  var got = _.strDifference( 'abc', 'abd' );
  var expected = 'ab*';
  test.identical( got, expected );

  test.description = 'returns the string where the difference in the first letter';
  var got = _.strDifference( 'abc', 'def' );
  var expected = '*';
  test.identical( got, expected );

  test.description = 'returns false because arguments are equal';
  var got = _.strDifference( 'abc', 'abc' );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strDifference( );
  } );

  test.description = 'first argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strDifference( [  ], 'abc' );
  } );

  test.description = 'second argument is wrong';
  test.shouldThrowError( function( )
  {
    _.strDifference( 'abc', 13 );
  } );

  test.description = 'not enough arguments';
  test.shouldThrowError( function( )
  {
    _.strDifference( 'abc' );
  } );

}

//

function strLattersSpectre( test )
{

  test.description = 'returns the object';
  var got = _.strLattersSpectre( 'abcacc' );
  var expected = { a: 2, b: 1, c: 3, length: 6 };
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.description = 'no arguments';
  test.shouldThrowError( function( )
  {
    _.strLattersSpectre( );
  } );

};

// --
//
// --

var Self =
{

  name : 'StringsExtra',
  silencing : 1,
  enabled : 1, //

  tests :
  {

    strCamelize : strCamelize,
    strFilenameFor : strFilenameFor,
    strHtmlEscape : strHtmlEscape,

    //

    strReplaceAll : strReplaceAll,
    strSorterParse : strSorterParse,

    //

    strMetricFormat : strMetricFormat,
    strMetricFormatBytes : strMetricFormatBytes,
    strToBytes : strToBytes,
    strTimeFormat : strTimeFormat,

    //

    strDifference : strDifference,
    strLattersSpectre : strLattersSpectre,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
