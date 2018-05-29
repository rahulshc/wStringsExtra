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
      require.resolve( toolsPath );
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

//

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

  if( Config.debug )
  {
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
}

//

function strFilenameFor( test )
{
  test.description = 'converts string to camelcase';
  var got = _.strFilenameFor( "'example\\file?name.txt" );
  var expected = '_example_file_name.txt';
  test.identical( got,expected );

  test.description = 'convertion with options';
  var got = _.strFilenameFor( "'example\\file?name.js",{ 'delimeter':'#' } );
  var expected = '#example#file#name.js';
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strFilenameFor( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {
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
      _.strFilenameFor( "'example\\file?name.txt",'wrong' );
    });


  }
}

//

function strExtractStrips( test )
{

  function onStrip( part )
  {
    var temp = part.split( ':' )
    if( temp.length === 2 )
    {
      return temp;
    }
    return undefined;
  }

  test.description = 'case 1';
  var str = 'this #background:red#is#background:default# text and # is not';
  var got = _.strExtractStrips( str, { onStrip : onStrip } );
  var expected =
  [
    'this ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not'
  ];
  test.identical( got, expected );

  test.description = 'case 2';
  var str = '#simple # text #background:red#is#background:default# text and # is not#';
  var got = _.strExtractStrips( str, { onStrip : onStrip } );
  var expected =
  [
    '#simple # text ', [ 'background', 'red' ], 'is', [ 'background', 'default' ], ' text and # is not#'
  ];
  test.identical( got, expected );

  test.description = 'case 3';
  var str = '#background:red#i#s#background:default##text';
  var got = _.strExtractStrips( str, { onStrip : onStrip } );
  var expected =
  [
    [ 'background', 'red' ], 'i#s', [ 'background', 'default' ], '#text'
  ];
  test.identical( got, expected );

  test.description = 'warapped by strips';
  var str = '#background:red#text#background:default#';
  var got = _.strExtractStrips( str, { onStrip : onStrip } );
  var expected =
  [
    [ 'background', 'red' ], 'text', [ 'background', 'default' ]
  ];
  test.identical( got, expected );

}

//

function strExtractStereoStrips( test )
{
  var got,expected;

  test.description = 'default';

  /* nothing */

  got = _.strExtractStereoStrips( '' );
  expected = [ '' ];
  test.identical( got, expected );

  /* prefix/postfix # by default*/

  got = _.strExtractStereoStrips( '#abc#' );
  expected = [ '', 'abc', '' ];
  test.identical( got, expected );

  //

  test.description = 'with options';

  /* pre/post are same*/

  got = _.strExtractStereoStrips.call( { prefix : '/', postfix : '/' }, '/abc/' );
  expected = [ '', 'abc', '' ];
  test.identical( got, expected );

  /**/

  got = _.strExtractStereoStrips.call( { prefix : '/', postfix : '/' }, '//abc//' );
  expected = [ '', '', 'abc', '', '' ];
  test.identical( got, expected );

  /* different pre/post */

  got = _.strExtractStereoStrips.call( { prefix : '/#', postfix : '#' }, '/#abc#' );
  expected = [ 'abc' ];
  test.identical( got, expected );

  /* postfix appears in source two times */
  got = _.strExtractStereoStrips.call( { prefix : '/', postfix : '#' }, '/ab#c#' );
  expected = [ 'ab', 'c#' ];
  test.identical( got, expected );

  /* onStrip #1 */
  function onStrip1( strip )
  {
    if( strip.length )
    return strip;
  }
  got = _.strExtractStereoStrips.call( { onStrip : onStrip1 }, '#abc#' );
  expected = [ '#abc#' ];
  test.identical( got, expected );

  /* onStrip #2 */
  function onStrip2( strip )
  {
    return strip + strip;
  }
  got = _.strExtractStereoStrips.call( { prefix : '/', postfix : '#', onStrip : onStrip2 }, '/abc#' );
  expected = [ 'abcabc' ];
  test.identical( got, expected );

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

var Self =
{

  name : 'StringTools tests 2',
  silencing : 1,

  tests :
  {

    strCamelize : strCamelize,
    strFilenameFor : strFilenameFor,

    strExtractStrips : strExtractStrips,
    strExtractStereoStrips : strExtractStereoStrips,
    strSorterParse : strSorterParse,

  }

}

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
