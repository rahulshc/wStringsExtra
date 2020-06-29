( function _StringTools_test_s_() {

'use strict';

if( typeof module !== 'undefined' )
{

  let _ = require( '../../../dwtools/Tools.s' );

  _.include( 'wTesting' );
  require( '../l5/StringTools.s' );
  _.include( 'wSelector' );

}

let select = _testerGlobal_.wTools.select;
let _ = _global_.wTools;

// --
//
// --

function strCamelize( test )
{

  test.case = 'converts string to camelcase';
  var got = _.strCamelize( 'a-b_c/d' );
  var expected = 'aBCD';
  test.identical( got,expected );

  test.case = 'string with spaces';
  var got = _.strCamelize( '.test -str_ing /with .spaces' );
  var expected = 'Test StrIng With Spaces';
  test.identical( got,expected );

  test.case = 'string with no spaces';
  var got = _.strCamelize( 'camel.case/string' );
  var expected = 'camelCaseString';
  test.identical( got,expected );

  test.case = 'empty string';
  var got = _.strCamelize( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strCamelize( 'one','two' );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strCamelize( );
  });

  test.case = 'wrong argument type';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strCamelize( 111 );
  });

  test.case = 'wrong argument type';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strCamelize( [ ] );
  });

}

//

function strToTitle( test )
{

  test.case = 'trivial';
  var src = 'someString';
  var expected = 'some string';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'trivial - first upper case';
  var src = 'SomeString';
  var expected = 'Some string';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  /* take into account this case */
  test.case = 'single letter prefeix';
  var src = 'wTranspStrat';
  var expected = 'Transp strat';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'several tokens';
  var src = 'abcEfgHigMigg';
  var expected = 'abc efg hig migg';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'with digits and spaces';
  var src = 'someString13 ThisIs14 1999 year1d';
  var expected = 'some string 13 This is 14 1999 year 1 d';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'with digits and spaces and underscore';
  var src = 'some_test_13_14_this is __13__ __x__';
  var expected = 'some test 13 14 this is 13 x';
  var got = _.strToTitle( src );
  test.identical( got, expected );

  test.case = 'with digits and spaces and dot';
  var src = 'some.test_13.14.this is ..13.. ..x..';
  var expected = 'some test 13 14 this is 13 x';
  var got = _.strToTitle( src );
  test.identical( got, expected );

}

//

function strFilenameFor( test )
{

  test.case = 'converts string to camelcase';
  var got = _.strFilenameFor( '"example\\file?name.txt' );
  var expected = '_example_file_name.txt';
  test.identical( got,expected );

  test.case = 'convertion with options';
  var got = _.strFilenameFor({ srcString : '\'example\\file?name.js', 'delimeter':'#' } );
  var expected = '#example#file#name.js';
  test.identical( got,expected );

  test.case = 'empty string';
  var got = _.strFilenameFor( '' );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strFilenameFor( 'one','two','three' );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strFilenameFor( );
  });

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strFilenameFor( 111 );
  });

  test.case = 'second argument is wrong';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strFilenameFor( '"example\\file?name.txt','wrong' );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strFilenameFor() );

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strFilenameFor( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strFilenameFor( null ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strFilenameFor( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strFilenameFor( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strFilenameFor( [] ) );

}

//

function strHtmlEscape( test )
{

  test.case = 'replaces html escape symbols';
  var got = _.strHtmlEscape( '<&test &text &here>' );
  var expected = '&lt;&amp;test &amp;text &amp;here&gt;';
  test.identical( got,expected );

  test.case = 'replaces html escape symbols from array';
  var got = _.strHtmlEscape( ['&','<'] );
  var expected = '&amp;,&lt;';
  test.identical( got,expected );

  test.case = 'object passed';
  var got = _.strHtmlEscape( {'prop': 'value'} );
  var expected = '[object Object]';
  test.identical( got,expected );

  test.case = 'empty string';
  var got = _.strHtmlEscape( '' );
  var expected = '';
  test.identical( got,expected );

  test.case = 'nothin replaced';
  var got = _.strHtmlEscape( 'text' );
  var expected = 'text';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strHtmlEscape( 'one','two' );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strHtmlEscape( );
  });

}

//

function strSearchDefaultOptions( test )
{
  test.open( 'ins - string' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [] } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src === ins';
  var got = _.strSearch( { src : 'abc', ins : 'abc' } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ '', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'aabaa', ins : 'b' } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 2, 3 ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'aa', 'b', 'aa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'aabaa', ins : 'aa' } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 0, 2  ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ '', 'aa', 'baa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 3, 5  ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'aab', 'aa', '' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'hello', ins : [ 'l', '', 'x' ] } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'hello',
      'charsRangeLeft' : [ 2, 3  ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'he', 'l', 'lo' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 4 ],
      'counter' : 1,
      'input' : 'hello',
      'charsRangeLeft' : [ 3, 4  ],
      'charsRangeRight' : [ 2, 1 ],
      'nearest' : [ 'hel', 'l', 'o' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'abaabab', ins : [ 'aa', 'ab', 'a' ] } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ '', 'ab', 'aabab' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 1,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 2, 4 ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ 'ab', 'aa', 'bab' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 5, 7 ],
      'counter' : 2,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 5, 7 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'abaab', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'abc', 'a' ] } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 6, 3 ],
      'nearest' : [ '', 'abc', 'abc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 6 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 6 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ 'abc', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'a', 'abc' ] } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 1 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 1 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ '', 'a', 'bcabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 4 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 4 ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'abc', 'a', 'bc' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string' );

  /* - */

  test.open( 'ins - regexp' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/ } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/ } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src === ins';
  var got = _.strSearch( { src : 'abc', ins : /abc/ } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ '', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'aabaa', ins : /b+/ } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 2, 3 ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'aa', 'b', 'aa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'aabaa', ins : /a+/ } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 0, 2  ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ '', 'aa', 'baa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 3, 5  ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'aab', 'aa', '' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'hello', ins : [ /l/gm, /(?:)/g, /x/ ] } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'hello',
      'charsRangeLeft' : [ 2, 3  ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'he', 'l', 'lo' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 4 ],
      'counter' : 1,
      'input' : 'hello',
      'charsRangeLeft' : [ 3, 4  ],
      'charsRangeRight' : [ 2, 1 ],
      'nearest' : [ 'hel', 'l', 'o' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'abaabab', ins : [ /aa+/, /ab/g, 'a' ] } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ '', 'ab', 'aabab' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 1,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 2, 4 ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ 'ab', 'aa', 'bab' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 5, 7 ],
      'counter' : 2,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 5, 7 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'abaab', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : 'abcabc', ins : [ /abc/g, /a/ ] } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 6, 3 ],
      'nearest' : [ '', 'abc', 'abc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 6 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 6 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ 'abc', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : 'abcabc', ins : [ /a+/, /abc/g ] } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 1 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 1 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ '', 'a', 'bcabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 4 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 4 ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'abc', 'a', 'bc' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strSearch() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strSearch( { src : 'abc', ins : 'a' }, 'b' ) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.strSearch( { src : 'abc', ins : 'a', charsRangeLeft : [ 1, 2 ] } ) );

  test.case = 'wrong type onTokenize';
  test.shouldThrowErrorSync( () => _.strSearch( { src : 'abc', ins : 'a', onTokenize : [] } ) );
}

//

function strSearchOptionNearestLines( test )
{
  test.open( 'ins - string, nearestLines - 2' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : 'abc',  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' : [ 'f\n', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'b',  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'aa\n', 'b', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'aa',  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' : [ 'f\n', 'aa', '' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' : [ 'b\n', 'aa', '' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ 'l', '', 'x' ],  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' : [ 'f\nhe', 'l', 'lo' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'f\nhel', 'l', 'o' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ 'aa', 'ab', 'a' ],  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' : [ '', 'ab', '' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ 'ab\n', 'aa', '' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'b\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 2 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' : [ '\n', 'abc', '' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' : [ 'abc\n', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' : [ '\n', 'a', 'bc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' : [ 'abc\n', 'a', 'bc' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string, nearestLines - 2' );

  /* - */

  test.open( 'ins - regexp, nearestLines - 2' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g,  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/,  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g,  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/,  nearestLines : 2 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : /abc/g,  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' : [ 'f\n', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /b+/g,  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'aa\n', 'b', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /a+/,  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' : [ 'f\n', 'aa', '' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' : [ 'b\n', 'aa', '' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ /[las]/, /a/, /x/ ],  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' : [ 'f\nhe', 'l', 'lo' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'f\nhel', 'l', 'o' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ /aa/g, /ab/, /a+/ ],  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' : [ '', 'ab', '' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ 'ab\n', 'aa', '' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'b\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 2 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' : [ '\n', 'abc', '' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' : [ 'abc\n', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 2 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' : [ '\n', 'a', 'bc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' : [ 'abc\n', 'a', 'bc' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, nearestLines - 2' );

  /* - */

  test.open( 'ins - string, nearestLines - 4' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : 'abc',  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' : [ 'f\nf\n', 'abc', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'b',  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'f\naa\n', 'b', '\naa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'aa',  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' : [ 'f\n', 'aa', '\nb' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' : [ 'aa\nb\n', 'aa', '\nf' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ 'l', '', 'x' ],  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' : [ 'f\nf\nhe', 'l', 'lo\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'f\nf\nhel', 'l', 'o\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ 'aa', 'ab', 'a' ],  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' : [ '', 'ab', '\naa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ 'ab\n', 'aa', '\nb' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'aa\nb\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 4 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' : [ '\n', 'abc', '\nabc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' : [ '\nabc\n', 'abc', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' : [ '\n', 'a', 'bc\nabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' : [ '\nabc\n', 'a', 'bc\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string, nearestLines - 4' );

  /* - */

  test.open( 'ins - regexp, nearestLines - 4' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g,  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/,  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g,  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/,  nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : /abc/g,  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' : [ 'f\nf\n', 'abc', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /b+/g,  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'f\naa\n', 'b', '\naa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /a+/,  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' : [ 'f\n', 'aa', '\nb' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' : [ 'aa\nb\n', 'aa', '\nf' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ /[las]/, /a/, /x/ ],  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' : [ 'f\nf\nhe', 'l', 'lo\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ 'f\nf\nhel', 'l', 'o\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ /aa/g, /ab/, /a+/ ],  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' : [ '', 'ab', '\naa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ 'ab\n', 'aa', '\nb' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'aa\nb\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 4 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' : [ '\n', 'abc', '\nabc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' : [ '\nabc\n', 'abc', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' : [ '\n', 'a', 'bc\nabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' : [ '\nabc\n', 'a', 'bc\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, nearestLines - 4' );
}

//

function strSearchOptionNearestSplitting( test )
{
  test.open( 'ins - string, nearestLines - 2' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : 'abc',  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' :  'f\nabc'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'b',  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'aa\nb'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'aa',  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' :  'f\naa'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' :  'b\naa'
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ 'l', '', 'x' ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  'f\nhello'
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'f\nhello'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ 'aa', 'ab', 'a' ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' :  'ab'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' :  'ab\naa'
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' :  'b\nab'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  '\nabc'
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  'abc\nabc'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' :  '\nabc'
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' :  'abc\nabc'
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string, nearestLines - 2' );

  /* - */

  test.open( 'ins - regexp, nearestLines - 2' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g,  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/,  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g,  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/,  nearestLines : 2, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : /abc/g,  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' :  'f\nabc'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /b+/g,  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'aa\nb'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /a+/,  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' :  'f\naa'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' :  'b\naa'
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ /[las]/, /a/, /x/ ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  'f\nhello'
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'f\nhello'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ /aa/g, /ab/, /a+/ ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' :  'ab'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' :  'ab\naa'
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' :  'b\nab'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  '\nabc'
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  'abc\nabc'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 2, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' :  '\nabc'
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' :  'abc\nabc'
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, nearestLines - 2' );

  /* - */

  test.open( 'ins - string, nearestLines - 4' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : 'abc',  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' :  'f\nf\nabc\nf'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'b',  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'f\naa\nb\naa'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'aa',  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' :  'f\naa\nb'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' :  'aa\nb\naa\nf'
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ 'l', '', 'x' ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  'f\nf\nhello\nf'
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'f\nf\nhello\nf'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ 'aa', 'ab', 'a' ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' :  'ab\naa'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' :  'ab\naa\nb'
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' :  'aa\nb\nab'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  '\nabc\nabc'
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  '\nabc\nabc\n'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' :  '\nabc\nabc'
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' :  '\nabc\nabc\n'
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string, nearestLines - 4' );

  /* - */

  test.open( 'ins - regexp, nearestLines - 4' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g,  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/,  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g,  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/,  nearestLines : 4, nearestSplitting : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : /abc/g,  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'nearest' :  'f\nf\nabc\nf'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /b+/g,  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'f\naa\nb\naa'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /a+/,  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' :  'f\naa\nb'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' :  'aa\nb\naa\nf'
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ /[las]/, /a/, /x/ ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  'f\nf\nhello\nf'
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  'f\nf\nhello\nf'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ /aa/g, /ab/, /a+/ ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' :  'ab\naa'
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' :  'ab\naa\nb'
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' :  'aa\nb\nab'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  '\nabc\nabc'
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  '\nabc\nabc\n'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  nearestLines : 4, nearestSplitting : 0 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' : '\nabc\nabc'
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' : '\nabc\nabc\n'
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, nearestLines - 4' );
}

//

function strSearchOptiondeterminingLineNumber( test )
{
  test.open( 'ins - string' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : 'abc',  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'f\n', 'abc', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'b',  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'aa\n', 'b', '\naa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'aa',  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'f\n', 'aa', '\nb' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 3, 4, 5 ],
      'nearest' : [ 'b\n', 'aa', '\nf' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ 'l', '', 'x' ],  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'f\nhe', 'l', 'lo\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'f\nhel', 'l', 'o\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ 'aa', 'ab', 'a' ],  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'linesRange' : [ 1, 2 ],
      'linesOffsets' : [ 1, 1, 2 ],
      'nearest' : [ '', 'ab', '\naa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'ab\n', 'aa', '\nb' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 3, 4, 5 ],
      'nearest' : [ 'b\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  determiningLineNumber : 1 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'abc', '\nabc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'abc\n', 'abc', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'a', 'bc\nabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'abc\n', 'a', 'bc\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string' );

  /* - */

  test.open( 'ins - regexp' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g,  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/,  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g,  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/,  determiningLineNumber : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : /abc/g,  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'f\n', 'abc', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /b+/g,  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'aa\n', 'b', '\naa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /a+/,  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'f\n', 'aa', '\nb' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 3, 4, 5 ],
      'nearest' : [ 'b\n', 'aa', '\nf' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ /[las]/, /a/, /x/ ],  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'f\nhe', 'l', 'lo\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'f\nhel', 'l', 'o\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ /aa/g, /ab/, /a+/ ],  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'linesRange' : [ 1, 2 ],
      'linesOffsets' : [ 1, 1, 2 ],
      'nearest' : [ '', 'ab', '\naa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'ab\n', 'aa', '\nb' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 3, 4, 5 ],
      'nearest' : [ 'b\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  determiningLineNumber : 1 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'abc', '\nabc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'abc\n', 'abc', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  determiningLineNumber : 1 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'a', 'bc\nabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'nearest' : [ 'abc\n', 'a', 'bc\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp' );

  /* - */

  test.open( 'ins - string, nearestLines - 4' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : 'abc',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\nf\n', 'abc', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'b',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\naa\n', 'b', '\naa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : 'aa',  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'f\n', 'aa', '\nb' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 2, 4, 5 ],
      'nearest' : [ 'aa\nb\n', 'aa', '\nf' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ 'l', '', 'x' ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\nf\nhe', 'l', 'lo\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\nf\nhel', 'l', 'o\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ 'aa', 'ab', 'a' ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'linesRange' : [ 1, 2 ],
      'linesOffsets' : [ 1, 1, 2 ],
      'nearest' : [ '', 'ab', '\naa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'ab\n', 'aa', '\nb' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 2, 4, 5 ],
      'nearest' : [ 'aa\nb\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 2, 3, 4 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'abc', '\nabc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ '\nabc\n', 'abc', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'a', 'bc\nabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ '\nabc\n', 'a', 'bc\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string, nearestLines - 4' );

  /* - */

  test.open( 'ins - regexp, nearestLines - 4' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nf\nabc\nf\nf', ins : /abc/g,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nabc\nf\nf',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 7, 4 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\nf\n', 'abc', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /b+/g,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\naa\n', 'b', '\naa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\naa\nb\naa\nf', ins : /a+/,  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'f\n', 'aa', '\nb' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\naa\nb\naa\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 2, 4, 5 ],
      'nearest' : [ 'aa\nb\n', 'aa', '\nf' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\nhello\nf\nf', ins : [ /[las]/, /a/, /x/ ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\nf\nhe', 'l', 'lo\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\nhello\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ 'f\nf\nhel', 'l', 'o\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : 'ab\naa\nb\nab', ins : [ /aa/g, /ab/, /a+/ ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'linesRange' : [ 1, 2 ],
      'linesOffsets' : [ 1, 1, 2 ],
      'nearest' : [ '', 'ab', '\naa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ 'ab\n', 'aa', '\nb' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : 'ab\naa\nb\nab',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'linesRange' : [ 4, 5 ],
      'linesOffsets' : [ 2, 4, 5 ],
      'nearest' : [ 'aa\nb\n', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'abc', 'a' ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'abc', '\nabc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ '\nabc\n', 'abc', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\nabc\nabc\n', ins : [ 'a', 'abc' ],  determiningLineNumber : 1, nearestLines : 4 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'linesRange' : [ 2, 3 ],
      'linesOffsets' : [ 1, 2, 3 ],
      'nearest' : [ '\n', 'a', 'bc\nabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      // 'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\nabc\nabc\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'linesRange' : [ 3, 4 ],
      'linesOffsets' : [ 1, 3, 4 ],
      'nearest' : [ '\nabc\n', 'a', 'bc\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, nearestLines - 4' );
}

//

function strSearchOptionStringWithRegexp( test )
{
  test.open( 'ins - simple string' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '',  stringWithRegexp : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x',  stringWithRegexp : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : 'abc', ins : '',  stringWithRegexp : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : 'hello', ins : 'x',  stringWithRegexp : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : 'hello', ins : [],  stringWithRegexp : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src === ins';
  var got = _.strSearch( { src : 'abc', ins : 'abc',  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ '', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'aabaa', ins : 'b',  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 2, 3 ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'aa', 'b', 'aa' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'aabaa', ins : 'aa',  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 0, 2  ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ '', 'aa', 'baa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 3, 5  ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'aab', 'aa', '' ]
    }
  ]
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'hello', ins : [ 'l', '', 'x' ],  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'hello',
      'charsRangeLeft' : [ 2, 3  ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'he', 'l', 'lo' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 4 ],
      'counter' : 1,
      'input' : 'hello',
      'charsRangeLeft' : [ 3, 4  ],
      'charsRangeRight' : [ 2, 1 ],
      'nearest' : [ 'hel', 'l', 'o' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : 'abaabab', ins : [ 'aa', 'ab', 'a' ],  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ '', 'ab', 'aabab' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 1,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 2, 4 ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ 'ab', 'aa', 'bab' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 5, 7 ],
      'counter' : 2,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 5, 7 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'abaab', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'abc', 'a' ],  stringWithRegexp : 1 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 6, 3 ],
      'nearest' : [ '', 'abc', 'abc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 6 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 6 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ 'abc', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'a', 'abc' ],  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 1 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 1 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' : [ '', 'a', 'bcabc' ]
    },
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 4 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 4 ],
      'charsRangeRight' : [ 3, 2 ],
      'nearest' : [ 'abc', 'a', 'bc' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - simple string' );

  /* - */

  test.open( 'ins - string with double slashes' );

  test.case = 'src - string, ins - has one symbol and double slash, not entry, stringWithRegexp - 0';
  var got = _.strSearch( { src : 'hello', ins : 'o//',  stringWithRegexp : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - has one symbol and double slash, not entry, stringWithRegexp - 1';
  var got = _.strSearch( { src : 'hello', ins : 'o//',  stringWithRegexp : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by double slash, stringWithRegexp - 0';
  var got = _.strSearch( { src : 'abc', ins : 'a//b//c',  stringWithRegexp : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by double slash, stringWithRegexp - 1';
  var got = _.strSearch( { src : 'abc', ins : 'a//b//c',  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ '', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by double slash, two entries, stringWithRegexp - 0';
  var got = _.strSearch( { src : 'aabaa', ins : 'a//a',  stringWithRegexp : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by double slash, two entries, stringWithRegexp - 1';
  var got = _.strSearch( { src : 'aabaa', ins : 'a//a//',  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 0, 2  ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ '', 'aa', 'baa' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'aabaa',
      'charsRangeLeft' : [ 3, 5  ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'aab', 'aa', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, separated by double slash, entries, stringWithRegexp : 0';
  var got = _.strSearch( { src : 'abaabab', ins : [ '//a//a', 'a//b//' ],  stringWithRegexp : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of strings, separated by double slash, entries, stringWithRegexp : 1';
  var got = _.strSearch( { src : 'abaabab', ins : [ 'a//a//', 'a//b//', 'a' ],  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' : [ '', 'ab', 'aabab' ]
    },
    {
      'match' : 'aa',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 1,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 2, 4 ],
      'charsRangeRight' : [ 5, 3 ],
      'nearest' : [ 'ab', 'aa', 'bab' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 5, 7 ],
      'counter' : 2,
      'input' : 'abaabab',
      'charsRangeLeft' : [ 5, 7 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' : [ 'abaab', 'ab', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by double slash, ins[ 0 ] explore full src, no other entries should be, stringWithRegexp - 0';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'a//b//c', 'a//b//' ],  stringWithRegexp : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by double slash, ins[ 0 ] explore full src, no other entries should be, stringWithRegexp - 1';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'a//b//c', 'a//b//' ],  stringWithRegexp : 1 } );
  var expected =
  [
   {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 3 ],
      'charsRangeRight' : [ 6, 3 ],
      'nearest' : [ '', 'abc', 'abc' ]
    },
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 6 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 6 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ 'abc', 'abc', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by double slash, ins[ 0 ] explore full src, no other entries should be, stringWithRegexp - 0';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'a//b//', 'ab//c' ],  stringWithRegexp : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by double slash, ins[ 0 ] explore full src, no other entries should be, stringWithRegexp - 1';
  var got = _.strSearch( { src : 'abcabc', ins : [ 'a//b//', 'ab//c' ],  stringWithRegexp : 1 } );
  var expected =
  [
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 6, 4 ],
      'nearest' : [ '', 'ab', 'cabc' ]
    },
    {
      'match' : 'ab',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : 'abcabc',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 3, 1 ],
      'nearest' : [ 'abc', 'ab', 'c' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string with double slashes' );
}

//

function strSearchOptionToleratingSpaces( test )
{
  test.open( 'ins - string with spaces' );

  test.case = 'src - string with two spaces, ins - has one symbol and one space, entry, toleratingSpaces - 0';
  var got = _.strSearch( { src : 'hello  ', ins : 'o ',  toleratingSpaces : 0 } );
  var expected =
  [
    {
      'match' : 'o ',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 6 ],
      'counter' : 0,
      'input' : 'hello  ',
      'charsRangeLeft' : [ 4, 6 ],
      'charsRangeRight' : [ 3, 1 ],
      'nearest' : [ 'hell', 'o ', ' ' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'src - string, ins - has one symbol and double slash, not entry, toleratingSpaces - 1';
  var got = _.strSearch( { src : 'hello  ', ins : 'o ',  toleratingSpaces : 1 } );
  var expected =
  [
    {
      'match' : 'o  ',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'hello  ',
      'charsRangeLeft' : [ 4, 7 ],
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ 'hell', 'o  ', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by one space, toleratingSpaces - 0';
  var got = _.strSearch( { src : 'a b c', ins : ' a b c ',  toleratingSpaces : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by one space, toleratingSpaces - 1';
  var got = _.strSearch( { src : 'a b c', ins : ' a b c ',  toleratingSpaces : 1 } );
  var expected =
  [
    {
      'match' : 'a b c',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 5 ],
      'counter' : 0,
      'input' : 'a b c',
      'charsRangeLeft' : [ 0, 5 ],
      'charsRangeRight' : [ 5, 0 ],
      'nearest' : [ '', 'a b c', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by double space, two entries, toleratingSpaces - 0';
  var got = _.strSearch( { src : 'a   aba   a', ins : 'a  a',  toleratingSpaces : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - symbols separated by double space, two entries, toleratingSpaces - 1';
  var got = _.strSearch( { src : 'a   aba   a', ins : 'a  a',  toleratingSpaces : 1 } );
  var expected =
  [
    {
      'match' : 'a   a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 5 ],
      'counter' : 0,
      'input' : 'a   aba   a',
      'charsRangeLeft' : [ 0, 5  ],
      'charsRangeRight' : [ 11, 6 ],
      'nearest' : [ '', 'a   a', 'ba   a' ]
    },
    {
      'match' : 'a   a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 11 ],
      'counter' : 1,
      'input' : 'a   aba   a',
      'charsRangeLeft' : [ 6, 11 ],
      'charsRangeRight' : [ 5, 0 ],
      'nearest' : [ 'a   ab', 'a   a', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, separated by spaces, entries, toleratingSpaces : 0';
  var got = _.strSearch( { src : 'a  b  a  a  b  a  b', ins : [ ' a a ', 'a b', '   a' ],  toleratingSpaces : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of strings, separated by double slash, entries, toleratingSpaces : 1';
  var got = _.strSearch( { src : 'a  b  a  a  b  a  b', ins : [ ' a a ', 'a b', '   a' ],  toleratingSpaces : 1 } );
  var expected =
  [
    {
      'match' : 'a  b',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 4 ],
      'counter' : 0,
      'input' : 'a  b  a  a  b  a  b',
      'charsRangeLeft' : [ 0, 4 ],
      'charsRangeRight' : [ 19, 15 ],
      'nearest' : [ '', 'a  b', '  a  a  b  a  b' ]
    },
    {
      'match' : '  a  a  ',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 12 ],
      'counter' : 1,
      'input' : 'a  b  a  a  b  a  b',
      'charsRangeLeft' : [ 4, 12 ],
      'charsRangeRight' : [ 15, 7 ],
      'nearest' : [ 'a  b', '  a  a  ', 'b  a  b' ]
    },
    {
      'match' : '  a',
      'groups' : [],
      'tokenId' : 2,
      'charsRangeLeft' : [ 13, 16 ],
      'counter' : 2,
      'input' : 'a  b  a  a  b  a  b',
      'charsRangeLeft' : [ 13, 16 ],
      'charsRangeRight' : [ 6, 3 ],
      'nearest' : [ 'a  b  a  a  b', '  a', '  b' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by space, ins[ 0 ] explore full src, no other entries should be, toleratingSpaces - 0';
  var got = _.strSearch( { src : 'a   b c a   b c', ins : [ ' a b c ', 'a b ' ],  toleratingSpaces : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by space, ins[ 0 ] explore full src, no other entries should be, toleratingSpaces - 1';
  var got = _.strSearch( { src : 'a   b c a   b c', ins : [ ' a b c ', 'a b ' ],  toleratingSpaces : 1 } );
  var expected =
  [
   {
      'match' : 'a   b c ',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 8 ],
      'counter' : 0,
      'input' : 'a   b c a   b c',
      'charsRangeLeft' : [ 0, 8 ],
      'charsRangeRight' : [ 15, 7 ],
      'nearest' : [ '', 'a   b c ', 'a   b c' ]
    },
    {
      'match' : 'a   b c',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 8, 15 ],
      'counter' : 1,
      'input' : 'a   b c a   b c',
      'charsRangeLeft' : [ 8, 15 ],
      'charsRangeRight' : [ 7, 0 ],
      'nearest' : [ 'a   b c ', 'a   b c', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by double slash, ins[ 0 ] explore full src, no other entries should be, toleratingSpaces - 0';
  var got = _.strSearch( { src : 'a   b c a   b c', ins : [ 'a b ', ' a b c ' ],  toleratingSpaces : 0 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of string, separated by double slash, ins[ 0 ] explore full src, no other entries should be, toleratingSpaces - 1';
  var got = _.strSearch( { src : 'a   b c a   b c', ins : [ 'a b ', ' a b c ' ],  toleratingSpaces : 1 } );
  var expected =
  [
   {
      'match' : 'a   b ',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 6 ],
      'counter' : 0,
      'input' : 'a   b c a   b c',
      'charsRangeLeft' : [ 0, 6 ],
      'charsRangeRight' : [ 15, 9 ],
      'nearest' : [ '', 'a   b ', 'c a   b c' ]
    },
    {
      'match' : 'a   b ',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 8, 14 ],
      'counter' : 1,
      'input' : 'a   b c a   b c',
      'charsRangeLeft' : [ 8, 14 ],
      'charsRangeRight' : [ 7, 1 ],
      'nearest' : [ 'a   b c ', 'a   b ', 'c' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string with spaces' );
}

//

function strSearchOptionOnTokenize( test )
{
  test.open( 'without excludingTokens' );

  test.open( 'ins - string' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '', onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x', onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : '//abc', ins : '', onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : '// hello', ins : 'x', onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : '/*hello*/', ins : [], onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nif\nabc\nin\nf', ins : 'abc', onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 0,
      'input' : 'f\nif\nabc\nin\nf',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  [ 'if\n', 'abc', '\nin' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strSearch( { src : 'f\nif\nb\nin\nf', ins : 'b', onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nin\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'if\n', 'b', '\nin' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strSearch( { src : 'f\nif\nb\nif\nf', ins : 'if', onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'if',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nif\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' :  [ 'f\n', 'if', '\nb' ]
    },
    {
      'match' : 'if',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\nif\nb\nif\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' :  [ 'b\n', 'if', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\n[all]\nf\nf', ins : [ 'l', '', 'x' ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  [ 'f\n[a', 'l', 'l]\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'f\n[al', 'l', ']\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strSearch( { src : '{}\n()\nb\n{}', ins : [ '()', '{}', 'a' ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : '{}',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : '{}\n()\nb\n{}',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' :  [ '', '{}', '\n()' ]
    },
    {
      'match' : '()',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : '{}\n()\nb\n{}',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' :  [ '{}\n', '()', '\nb' ]
    },
    {
      'match' : '{}',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : '{}\n()\nb\n{}',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' :  [ 'b\n', '{}', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ '(a)', 'a' ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
   {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  [ '\n', '(a)', '\n(a)' ]
    },
    {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  [ '(a)\n', '(a)', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ '(', '(a)' ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : '(',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' :  [ '\n', '(', 'a)\n(a)' ]
    },
    {
      'match' : '(',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' :  [ '(a)\n', '(', 'a)\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string' );

  /* - */

  test.open( 'ins - regexp' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g, onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/, onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g, onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/, onTokenize : _.strTokenizeJs } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline';
  var got = _.strSearch( { src : 'f\nif\nabc\nin\nf', ins : /abc/g, onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 0,
      'input' : 'f\nif\nabc\nin\nf',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  [ 'if\n', 'abc', '\nin' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\nif\nb\nin\nf', ins : /b+/g, onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nin\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'if\n', 'b', '\nin' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries';
  var got = _.strSearch( { src : 'f\nif\nb\nif\nf', ins : /if+/, onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'if',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 4 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nif\nf',
      'charsRangeLeft' : [ 2, 4  ],
      'charsRangeRight' : [ 9, 7 ],
      'nearest' :  [ 'f\n', 'if', '\nb' ]
    },
    {
      'match' : 'if',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 9 ],
      'counter' : 1,
      'input' : 'f\nif\nb\nif\nf',
      'charsRangeLeft' : [ 7, 9  ],
      'charsRangeRight' : [ 4, 2 ],
      'nearest' :  [ 'b\n', 'if', '\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\n[all]\nf\nf', ins : [ /[los]/, /o/, /x/ ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  [ 'f\n[a', 'l', 'l]\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'f\n[al', 'l', ']\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries';
  var got = _.strSearch( { src : '{}\n()\nb\n{}', ins : [ /\(\)/g, /\{\}/, /if+/ ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : '{}',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 0, 2 ],
      'counter' : 0,
      'input' : '{}\n()\nb\n{}',
      'charsRangeLeft' : [ 0, 2 ],
      'charsRangeRight' : [ 10, 8 ],
      'nearest' :  [ '', '{}', '\n()' ]
    },
    {
      'match' : '()',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 1,
      'input' : '{}\n()\nb\n{}',
      'charsRangeLeft' : [ 3, 5 ],
      'charsRangeRight' : [ 7, 5 ],
      'nearest' :  [ '{}\n', '()', '\nb' ]
    },
    {
      'match' : '{}',
      'groups' : [],
      'tokenId' : 1,
      'charsRangeLeft' : [ 8, 10 ],
      'counter' : 2,
      'input' : '{}\n()\nb\n{}',
      'charsRangeLeft' : [ 8, 10 ],
      'charsRangeRight' : [ 2, 0 ],
      'nearest' :  [ 'b\n', '{}', '' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ /\(a\)/, /\(/ ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
   {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  [ '\n', '(a)', '\n(a)' ]
    },
    {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  [ '(a)\n', '(a)', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ /\(/, /\(a\)/ ], onTokenize : _.strTokenizeJs } );
  var expected =
  [
    {
      'match' : '(',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 1, 2 ],
      'charsRangeRight' : [ 8, 7 ],
      'nearest' :  [ '\n', '(', 'a)\n(a)' ]
    },
    {
      'match' : '(',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 1,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 4, 3 ],
      'nearest' :  [ '(a)\n', '(', 'a)\n' ]
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp' );

  test.close( 'without excludingTokens' );

  /* - */

  test.open( 'excludingTokens' );

  test.open( 'ins - string' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strSearch( { src : '', ins : '', onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strSearch( { src : '', ins : 'x', onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strSearch( { src : '//abc', ins : '', onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strSearch( { src : '// hello', ins : 'x', onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strSearch( { src : '/*hello*/', ins : [], onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline, with excludingTokens with glob';
  var got = _.strSearch( { src : 'f\nif\nabc\nin\nf', ins : 'abc', onTokenize : _.strTokenizeJs, excludingTokens : 'na*' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - string, one entry, not excludingTokens';
  var got = _.strSearch( { src : 'f\nif\nb\nin\nf', ins : 'b', onTokenize : _.strTokenizeJs, excludingTokens : 'keyword' } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nin\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'if\n', 'b', '\nin' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries of excludingTokens';
  var got = _.strSearch( { src : 'f\nif\nb\nif\nf', ins : 'if', onTokenize : _.strTokenizeJs, excludingTokens : [ 'name', 'keywo??' ] } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\n[all]\nf\nf', ins : [ 'l', '', 'x' ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'parenthes' ] } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  [ 'f\n[a', 'l', 'l]\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'f\n[al', 'l', ']\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries, excludingTokens';
  var got = _.strSearch( { src : '{}\n()\nb\n{}', ins : [ '()', '{}', 'a' ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'cu???', 'parenthes' ] } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ '(a)', 'a' ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'square' ] } );
  var expected =
  [
   {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  [ '\n', '(a)', '\n(a)' ]
    },
    {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  [ '(a)\n', '(a)', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be, excludingTokens';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ '(', '(a)' ], onTokenize : _.strTokenizeJs, excludingTokens : 'parenthes' } );
  var expected = [];
  test.identical( got, expected );

  test.close( 'ins - string' );

  /* - */

  test.open( 'ins - regexp' );

  test.case = 'src - empty string, ins - regexp for empty strings';
  var got = _.strSearch( { src : '', ins : /(?:)/g, onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - regexp';
  var got = _.strSearch( { src : '', ins : /x/, onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp for empty string';
  var got = _.strSearch( { src : 'abc', ins : /(?:)/g, onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp, not entry';
  var got = _.strSearch( { src : 'hello', ins : /x/, onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - multiline, excludingTokens';
  var got = _.strSearch( { src : 'f\nif\nabc\nin\nf', ins : /abc/g, onTokenize : _.strTokenizeJs, excludingTokens : 'name' } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - regexp, one entry';
  var got = _.strSearch( { src : 'f\nif\nb\nin\nf', ins : /b+/g, onTokenize : _.strTokenizeJs, excludingTokens : 'keyword' } );
  var expected =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nin\nf',
      'charsRangeLeft' : [ 5, 6 ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'if\n', 'b', '\nin' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp, two entries, excludingTokens';
  var got = _.strSearch( { src : 'f\nif\nb\nif\nf', ins : /if+/, onTokenize : _.strTokenizeJs, excludingTokens : [ 'name', 'keyword' ] } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, has empty string, two entries of single ins';
  var got = _.strSearch( { src : 'f\nf\n[all]\nf\nf', ins : [ /[los]/, /o/, /x/ ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'parenthes' ] } );
  var expected =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 6, 7  ],
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  [ 'f\n[a', 'l', 'l]\nf' ]
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeLeft' : [ 7, 8  ],
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'f\n[al', 'l', ']\nf' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, entries, excludingTokens';
  var got = _.strSearch( { src : '{}\n()\nb\n{}', ins : [ /\(\)/g, /\{\}/, /if+/ ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'parenthes' ] } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ /\(a\)/, /\(/ ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'square' ] } );
  var expected =
  [
   {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 4 ],
      'counter' : 0,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 1, 4 ],
      'charsRangeRight' : [ 8, 5 ],
      'nearest' :  [ '\n', '(a)', '\n(a)' ]
    },
    {
      'match' : '(a)',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 8 ],
      'counter' : 1,
      'input' : '\n(a)\n(a)\n',
      'charsRangeLeft' : [ 5, 8 ],
      'charsRangeRight' : [ 4, 1 ],
      'nearest' :  [ '(a)\n', '(a)', '\n' ]
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, ins[ 0 ] explore full src, no other entries should be, excludingTokens';
  var got = _.strSearch( { src : '\n(a)\n(a)\n', ins : [ /\(/, /\(a\)/ ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'parenthes' ] } );
  var expected = [];
  test.identical( got, expected );

  test.close( 'ins - regexp' );

  test.close( 'excludingTokens' );
}

//

function strSearchLog( test )
{
  test.open( 'one line' );

  test.case = '1 letter match at the start - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'a' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 1 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 7, 6 ],
      'nearest' : [ '', 'a', 'bcdefg' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = '1 letter match at the middle - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'c' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'c',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 3 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 5, 4 ],
      'nearest' : [ 'ab', 'c', 'defg' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = '1 letter match at the end - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'g' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'g',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 1, 0 ],
      'nearest' : [ 'abcdef', 'g', '' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );
  
  /* */

  test.case = 'a few letters match at the start - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'abc' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'abc',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 3 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 7, 4 ],
      'nearest' : [ '', 'abc', 'defg' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'a few letters match at the middle - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'cde' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'cde',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 2, 5 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 5, 2 ],
      'nearest' : [ 'ab', 'cde', 'fg' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'a few letters match at the end - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'efg' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'efg',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 7 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 3, 0 ],
      'nearest' : [ 'abcd', 'efg', '' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  /* */

  test.case = 'all letters match - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'abcdefg' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'abcdefg',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 7 ],
      'counter' : 0,
      'input' : 'abcdefg',
      'charsRangeRight' : [ 7, 0 ],
      'nearest' : [ '', 'abcdefg', '' ],
      'log' : '1 : abcdefg',
      'sub' : null
    }
  ];
  var expectedLog = '1 : abcdefg';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'no match - one line'
  var input = 
  {
    src : 'abcdefg',
    ins : [ 'h' ],
    gray : 1
  }
  var expectedParcels = [];
  var expectedLog = '';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  /* */ 

  test.case = 'multiple matches 1 letter  - one line'
  var input = 
  {
    src : 'abcabcabc',
    ins : [ 'a' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      match : 'a',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : 'abcabcabc',
      charsRangeRight : [ 9, 8 ],
      nearest : [ '', 'a', 'bcabcabc' ],
      log : '1 : abcabcabc',
      sub : null
    },
    {
      match : 'a',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 3, 4 ],
      counter : 1,
      input : 'abcabcabc',
      charsRangeRight : [ 6, 5 ],
      nearest : [ 'abc', 'a', 'bcabc' ],
      log : '1 : abcabcabc',
      sub : null
    },
    {
      match : 'a',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 6, 7 ],
      counter : 2,
      input : 'abcabcabc',
      charsRangeRight : [ 3, 2 ],
      nearest : [ 'abcabc', 'a', 'bc' ],
      log : '1 : abcabcabc',
      sub : null
    }
  ]
  var expectedLog = '1 : abcabcabc\n1 : abcabcabc\n1 : abcabcabc';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'multiple matches a few letters - one line'
  var input = 
  {
    src : 'abcabcabc',
    ins : [ 'bc' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      match : 'bc',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 1, 3 ],
      counter : 0,
      input : 'abcabcabc',
      charsRangeRight : [ 8, 6 ],
      nearest : [ 'a', 'bc', 'abcabc' ],
      log : '1 : abcabcabc',
      sub : null
    },
    {
      match : 'bc',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 4, 6 ],
      counter : 1,
      input : 'abcabcabc',
      charsRangeRight : [ 5, 3 ],
      nearest : [ 'abca', 'bc', 'abc' ],
      log : '1 : abcabcabc',
      sub : null
    },
    {
      match : 'bc',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 7, 9 ],
      counter : 2,
      input : 'abcabcabc',
      charsRangeRight : [ 2, 0 ],
      nearest : [ 'abcabca', 'bc', '' ],
      log : '1 : abcabcabc',
      sub : null
    }
  ]
  var expectedLog = '1 : abcabcabc\n1 : abcabcabc\n1 : abcabcabc';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  /* */

  test.case = 'src - empty string, ins - regexp for empty strings';
  var input = { src : '', ins : /(?:)/g, onTokenize : _.strTokenizeJs, excludingTokens : 'name', gray : 1  };
  var got = _.strSearchLog( input );
  var expectedParcels = [];
  var expectedLog = '';
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog )

  test.case = 'src - string, ins - regexp for empty string';
  var input = { src : 'abc', ins : /(?:)/g, onTokenize : _.strTokenizeJs, excludingTokens : 'name', gray : 1  };
  var got = _.strSearchLog( input );
  var expectedParcels = [];
  var expectedLog = '';
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'src - empty string, ins - regexp';
  var input = { src : '', ins : /x/, onTokenize : _.strTokenizeJs, excludingTokens : 'name', gray : 1 };
  var got = _.strSearchLog( input );
  console.log(got)
  var expectedParcels = [];
  var expectedLog = '';
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );


  test.case = 'src - string, ins - regexp, not entry';
  var input = { src : 'hello', ins : /x/, onTokenize : _.strTokenizeJs, excludingTokens : 'name', gray : 1 };
  var got = _.strSearchLog( input );
  var expectedParcels = [];
  var expectedLog = '';
  console.log(got)
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.close( 'one line' );

  /* - */

  test.open( 'multiple lines' );

  test.case = '1 letter match at first line - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'a' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'a',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 1 ],
      'counter' : 0,
      'input' : 'ab\ncd\nef\ngh',
      'charsRangeRight' : [ 11, 10 ],
      'nearest' : [ '', 'a', 'b\ncd' ],
      'log' : '1 : ab\n2 : cd',
      'sub' : null
    }
  ];
  var expectedLog = '1 : ab\n2 : cd';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = '1 letter match at the middle line - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'd' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'd',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 5 ],
      'counter' : 0,
      'input' : 'ab\ncd\nef\ngh',
      'charsRangeRight' : [ 7, 6 ],
      'nearest' : [ 'ab\nc', 'd', '\nef' ],
      'log' : '1 : ab\n2 : cd\n3 : ef',
      'sub' : null
    }
  ];
  var expectedLog = '1 : ab\n2 : cd\n3 : ef';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = '1 letter match at the last line - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'g' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'g',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 9, 10 ],
      'counter' : 0,
      'input' : 'ab\ncd\nef\ngh',
      'charsRangeRight' : [ 2, 1 ],
      'nearest' : [ 'ef\n', 'g', 'h' ],
      'log' : '3 : ef\n4 : gh',
      'sub' : null
    }
  ];
  var expectedLog = '3 : ef\n4 : gh';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  /* */

  test.case = 'a few letters match - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'cd' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'cd',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 5 ],
      'counter' : 0,
      'input' : 'ab\ncd\nef\ngh',
      'charsRangeRight' : [ 2, 1 ],
      'nearest' : [ 'ab\n', 'cd', '\nef' ],
      'log' : '1 : ab\n2 : cd\n3 : ef',
      'sub' : null
    }
  ];
  var expectedLog = '1 : ab\n2 : cd\n3 : ef';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'a few letters match across lines - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'cd\nef' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'cdef',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 3, 8 ],
      'counter' : 0,
      'input' : 'ab\ncd\nef\ngh',
      'charsRangeRight' : [ 8, 3 ],
      'nearest' : [ '', 'cd\nef', '' ],
      'log' : '2 : cd\n3 : ef',
      'sub' : null
    }
  ];
  var expectedLog = '2 : cd\n3 : ef';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'a few letters wrong match (without line break) across lines - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'cdef' ],
    gray : 1
  }
  var expectedParcels = [];
  var expectedLog = '';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'all letters match - multiple lines'
  var input = 
  {
    src : 'ab\ncd\nef\ngh',
    ins : [ 'ab\ncd\nef\ngh' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {
      'match' : 'ab\ncd\nef\ngh',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 11 ],
      'counter' : 0,
      'input' : 'ab\ncd\nef\ngh',
      'charsRangeRight' : [ 11, 0 ],
      'nearest' : [ '', 'ab\ncd\nef\ngh', '' ],
      'log' : '1 : ab\n2 : cd\n3 : ef\n4 : gh',
      'sub' : null
    }
  ];
  var expectedLog = '1 : ab\n2 : cd\n3 : ef\n4 : gh';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  /* */

  test.case = 'a few matches on different lines - multiple lines'
  var input = 
  {
    src : 'ab\nab\nef\nab',
    ins : [ 'ab' ],
    gray : 1
  }
  var expectedParcels = 
  [
    {      
      match: 'ab',
      groups: [],
      tokenId: 0,
      charsRangeLeft: [ 0, 2 ],     
      counter: 0,
      input: 'ab\nab\nef\nab',      
      charsRangeRight: [ 11, 9 ],   
      nearest: [ '', 'ab', '\nab' ],
      log: '1 : ab\n2 : ab',
      sub: null
    },
    {
      match: 'ab',
      groups: [],
      tokenId: 0,
      charsRangeLeft: [ 3, 5 ],
      counter: 1,
      input: 'ab\nab\nef\nab',
      charsRangeRight: [ 8, 6 ],
      nearest: [ 'ab\n', 'ab', '\nef' ],
      log: '1 : ab\n2 : ab\n3 : ef',
      sub: null
    },
    {
      match: 'ab',
      groups: [],
      tokenId: 0,
      charsRangeLeft: [ 9, 11 ],
      counter: 2,
      input: 'ab\nab\nef\nab',
      charsRangeRight: [ 2, 0 ],
      nearest: [ 'ef\n', 'ab', '' ],
      log: '3 : ef\n4 : ab',
      sub: null
    }
  ];
  var expectedLog = '1 : ab\n2 : ab\n1 : ab\n2 : ab\n3 : ef\n3 : ef\n4 : ab';
  var got = _.strSearchLog( input );
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  /* */

  test.case = 'src - multiline, excludingTokens - multiple lines';
  var input = { src : 'f\nif\nabc\nin\nf', ins : /abc/g, onTokenize : _.strTokenizeJs, excludingTokens : 'name', gray : 1 };
  var got = _.strSearchLog( input );
  var expectedParcels = [];
  var expectedLog = '';
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'ins - regexp, two entries, excludingTokens - multiple lines';
  var input = { src : 'f\nif\nb\nif\nf', ins : /if+/, onTokenize : _.strTokenizeJs, excludingTokens : [ 'name', 'keyword' ], gray : 1 };
  var got = _.strSearchLog( input );
  var expectedParcels = [];
  var expectedLog = '';
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog );

  test.case = 'ins - regexp, one entry - multiple lines';
  var input = { src : 'f\nif\nb\nin\nf', ins : /b+/g, onTokenize : _.strTokenizeJs, excludingTokens : 'keyword', gray : 1 };
  var got = _.strSearchLog( input );
  var expectedParcels =
  [
    {
      'match' : 'b',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 5, 6 ],
      'counter' : 0,
      'input' : 'f\nif\nb\nin\nf',
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'if\n', 'b', '\nin' ],
      'log' : '2 : if\n3 : b\n4 : in',
      'sub' : null
    }
  ];
  var expectedLog = '2 : if\n3 : b\n4 : in';
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog )

  test.case = 'ins - array of regexps, has empty string, two entries of single ins - multiple lines';
  var input = { src : 'f\nf\n[all]\nf\nf', ins : [ /[los]/, /o/, /x/ ], onTokenize : _.strTokenizeJs, excludingTokens : [ 'curly', 'parenthes' ], gray : 1 };
  var got = _.strSearchLog( input );
  var expectedParcels =
  [
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 6, 7 ],
      'counter' : 0,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeRight' : [ 7, 6 ],
      'nearest' :  [ 'f\n[a', 'l', 'l]\nf' ],
      'log' : '2 : f\n3 : [all]\n4 : f',
      'sub' : null
    },
    {
      'match' : 'l',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 7, 8 ],
      'counter' : 1,
      'input' : 'f\nf\n[all]\nf\nf',
      'charsRangeRight' : [ 6, 5 ],
      'nearest' :  [ 'f\n[al', 'l', ']\nf' ],
      'log' : '2 : f\n3 : [all]\n4 : f',
      'sub' : null
    }
  ];
  var expectedLog = '2 : f\n3 : [all]\n4 : f\n2 : f\n3 : [all]\n4 : f';
  console.log(got.parcels)
  test.identical( got.parcels, expectedParcels );
  test.identical( got.log, expectedLog )

  test.close( 'multiple lines' );
  
  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'Wrong arguments : without arguments';
  test.shouldThrowErrorSync( () => _.strSearchLog() );

  test.case = 'Wrong arguments : wrong type of argument';
  test.shouldThrowErrorSync( () => _.strSearchLog( 13 ) );

  test.case = 'Wrong arguments : extra arguments';
  test.shouldThrowErrorSync( () => _.strSearchLog( { src : 'abcabcabc', ins : [ 'bc' ], gray : 1 }, 13 ) );

  test.close( 'throwing' );

}

//

function strSearchReplace( test )
{
  // test.open( 'one line' );

  // test.case = 'replace 1 letter at the middle - one line';
  // var expectedReplaced = 
  // [
  //   {
  //     input : 'aa_aa',
  //     log : '1 : aa_aa',
  //     nearest : [ 'aa', '_', 'aa' ],
  //     match : '_',
  //     groups : [],
  //     tokenId : 0,
  //     charsRangeLeft : [ 2, 3 ],
  //     counter : 0,
  //     charsRangeRight : [ 3, 2 ],
  //     sub : null
  //   }
  // ];
  // var got = _.strSearchReplace({ src : 'aabaa', ins : 'b', gray : 1 });
  // test.identical( got.replaced, expectedReplaced );

  // test.case = 'replace multiple letters - one line';
  // var expectedReplaced = 
  // [
  //   {
  //     input : '__b__',
  //     log : '1 : __b__',
  //     nearest : [ '', '_', '_b__' ],
  //     match : '_',
  //     groups : [],
  //     tokenId : 0,
  //     charsRangeLeft : [ 0, 1 ],
  //     counter : 0,
  //     charsRangeRight : [ 5, 4 ],
  //     sub : null
  //   },
  //   {
  //     input : '__b__',
  //     log : '1 : __b__',
  //     nearest : [ '_', '_', 'b__' ],
  //     match : '_',
  //     groups : [],
  //     tokenId : 0,
  //     charsRangeLeft : [ 1, 2 ],
  //     counter : 1,
  //     charsRangeRight : [ 4, 3 ],
  //     sub : null
  //   },
  //   {
  //     input : '__b__',
  //     log : '1 : __b__',
  //     nearest : [ '__b', '_', '_' ],
  //     match : '_',
  //     groups : [],
  //     tokenId : 0,
  //     charsRangeLeft : [ 3, 4 ],
  //     counter : 2,
  //     charsRangeRight : [ 2, 1 ],
  //     sub : null
  //   },
  //   {
  //     input : '__b__',
  //     log : '1 : __b__',
  //     nearest : [ '__b_', '_', '' ],
  //     match : '_',
  //     groups : [],
  //     tokenId : 0,
  //     charsRangeLeft : [ 4, 5 ],
  //     counter : 3,
  //     charsRangeRight : [ 1, 0 ],
  //     sub : null
  //   }
  // ];
  var got = _.strSearchReplace({ src : 'aabaa', parcels : _.strSearch({ src : 'aabaa', ins : [ 'a' ]}) });
  console.log( got );
  // test.identical( got.replaced, expectedReplaced );

  // test.close( 'one line' );

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'Wrong arguments : without arguments';
  test.shouldThrowErrorSync( () => _.strSearchLog() );

  test.case = 'Wrong arguments : wrong type of argument';
  test.shouldThrowErrorSync( () => _.strSearchLog( 13 ) );

  test.close( 'throwing' );
}

//

/*
  qqq : duplicate test cases for fast : 1 | Dmytro : improved test routine and added test cases with fast : 1
*/

function strFindAll( test )
{
  test.open( 'ins - string, fast - 0' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strFindAll( '', '' );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strFindAll( '', 'x' );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strFindAll( 'abc', '' );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strFindAll( 'hello', 'x' );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strFindAll( 'hello', [] );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src === ins';
  var got = _.strFindAll( 'abc', 'abc' );
  var expected =
  [
    {
      groups : [],
      match : 'abc',
      tokenId : 0,
      charsRangeLeft : [ 0, 3 ],
      counter : 0,
      input : 'abc'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strFindAll( 'aabaa', 'b' );
  var expected =
  [
    {
      groups : [],
      match : 'b',
      tokenId : 0,
      charsRangeLeft : [ 2, 3 ],
      counter : 0,
      input : 'aabaa'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strFindAll( 'aabaa', 'aa' );
  var expected =
  [
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 0, 2 ],
      counter : 0,
      input : 'aabaa'
    },
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 3, 5 ],
      counter : 1,
      input : 'aabaa'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strFindAll( 'hello', [ 'l', '', 'x' ] );
  var expected =
  [
    {
      groups : [],
      match : 'l',
      tokenId : 0,
      charsRangeLeft : [ 2, 3 ],
      counter : 0,
      input : 'hello'
    },
    {
      groups : [],
      match : 'l',
      tokenId : 0,
      charsRangeLeft : [ 3, 4 ],
      counter : 1,
      input : 'hello'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strFindAll( 'abaabab', [ 'aa', 'ab', 'a' ] );
  var expected =
  [
    {
      groups : [],
      match : 'ab',
      tokenId : 1,
      charsRangeLeft : [ 0, 2 ],
      counter : 0,
      input : 'abaabab'
    },
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 2, 4 ],
      counter : 1,
      input : 'abaabab'
    },
    {
      groups : [],
      match : 'ab',
      tokenId : 1,
      charsRangeLeft : [ 5, 7 ],
      counter : 2,
      input : 'abaabab'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strFindAll( 'abcabc', [ 'abc', 'a' ] );
  var expected =
  [
    {
      groups : [],
      match : 'abc',
      tokenId : 0,
      charsRangeLeft : [ 0, 3 ],
      counter : 0,
      input : 'abcabc'
    },
    {
      groups : [],
      match : 'abc',
      tokenId : 0,
      charsRangeLeft : [ 3, 6 ],
      counter : 1,
      input : 'abcabc'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strFindAll( 'abcabc', [ 'a', 'abc' ] );
  var expected =
  [
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : 'abcabc'
    },
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 3, 4 ],
      counter : 1,
      input : 'abcabc'
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - string, fast - 0' );

  /* - */

  test.open( 'ins - string, fast - 1' );

  test.case = 'src - empty string, ins - empty string';
  var got = _.strFindAll( { src : '', ins : '', fast : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - empty string, ins - string';
  var got = _.strFindAll( { src : '', ins : 'x', fast : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty string';
  var got = _.strFindAll( { src : 'abc', ins : '', fast : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - string, not entry';
  var got = _.strFindAll( { src : 'hello', ins : 'x', fast : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty array';
  var got = _.strFindAll( { src : 'hello', ins : [], fast : 1 } );
  var expected = [];
  test.identical( got, expected );

  test.case = 'src === ins';
  var got = _.strFindAll( { src : 'abc', ins : 'abc', fast : 1 } );
  var expected = [ [ 0, 3, 0 ] ];
  test.identical( got, expected );

  test.case = 'ins - string, one entry';
  var got = _.strFindAll( { src : 'aabaa', ins : 'b', fast : 1 } );
  var expected = [ [ 2, 3, 0 ] ];
  test.identical( got, expected );

  test.case = 'ins - string, two entries';
  var got = _.strFindAll( { src : 'aabaa', ins : 'aa', fast : 1 } );
  var expected =
  [
    [ 0, 2, 0 ],
    [ 3, 5, 0 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, has empty string, two entries of single ins';
  var got = _.strFindAll( { src : 'hello', ins : [ 'l', '', 'x' ], fast : 1 } );
  var expected =
  [
    [ 2, 3, 0 ],
    [ 3, 4, 0 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - array of strings, entries';
  var got = _.strFindAll( { src : 'abaabab', ins : [ 'aa', 'ab', 'a' ], fast : 1 } );
  var expected =
  [
    [ 0, 2, 1 ],
    [ 2, 4, 0 ],
    [ 5, 7, 1 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strFindAll( { src : 'abcabc', ins : [ 'abc', 'a' ], fast : 1 } );
  var expected =
  [
    [ 0, 3, 0 ],
    [ 3, 6, 0 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - array of string, ins[ 0 ] explore full src, no other entries should be';
  var got = _.strFindAll( { src : 'abcabc', ins : [ 'a', 'abc' ], fast : 1 } );
  var expected =
  [
    [ 0, 1, 0 ],
    [ 3, 4, 0 ]
  ];
  test.identical( got, expected );

  test.close( 'ins - string, fast - 1' );

  /* - */

  test.open( 'ins - regexp, fast - 0' );

  test.case = 'ins - simple regexp, two entries';
  var got = _.strFindAll( 'this is hello from hell', /hell/ );
  var expected =
  [
    {
      groups : [],
      match : 'hell',
      tokenId : 0,
      charsRangeLeft : [ 8, 12 ],
      counter : 0,
      input : 'this is hello from hell'
    },
    {
      groups : [],
      match : 'hell',
      tokenId : 0,
      charsRangeLeft : [ 19, 23 ],
      counter : 1,
      input : 'this is hello from hell'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp for numbers, flag "gm", three entries';
  var got = _.strFindAll( '12345', /[1-3]/gm );
  var expected =
  [
    {
      groups : [],
      match : '1',
      tokenId : 0,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : '12345'
    },
    {
      groups : [],
      match : '2',
      tokenId : 0,
      charsRangeLeft : [ 1, 2 ],
      counter : 1,
      input : '12345'
    },
    {
      groups : [],
      match : '3',
      tokenId : 0,
      charsRangeLeft : [ 2, 3 ],
      counter : 2,
      input : '12345'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp for a few "a", entry';
  var got = _.strFindAll( 'gpbaac', /a+/ );
  var expected =
  [
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 3, 5 ],
      counter : 0,
      input : 'gpbaac'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - complex regexp, flag "gm"';
  var got = _.strFindAll( 'gpbgpcgpd', /(gp)+[^bc]$/gm );
  var expected =
  [
    {
      groups : [ 'gp' ],
      match : 'gpd',
      tokenId : 0,
      charsRangeLeft : [ 6, 9 ],
      counter : 0,
      input : 'gpbgpcgpd'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, one entry';
  var got = _.strFindAll( 'gpa', [ /^d/, /p$/, /a/ ] );
  var expected =
  [
    {
      groups : [],
      match : 'a',
      tokenId : 2,
      charsRangeLeft : [ 2, 3 ],
      counter : 0,
      input : 'gpa'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, flag "gm", two entries';
  var got = _.strFindAll( 'gpahpb', [ /a/, /b/gm ] );
  var expected =
  [
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [],
      match : 'b',
      tokenId : 1,
      charsRangeLeft : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps and strings, flag "gm", entries';
  var got = _.strFindAll( 'gpahpb', [ /a/gm, 'f', /k$/, 'b' ] );
  var expected =
  [
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 2, 3 ],
      counter : 0,
      input : 'gpahpb'
    },
    {
      groups : [],
      match : 'b',
      tokenId : 3,
      charsRangeLeft : [ 5, 6 ],
      counter : 1,
      input : 'gpahpb'
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, fast - 0' );

  /* - */

  test.open( 'ins - regexp, fast - 1' );

  test.case = 'ins - simple regexp, two entries';
  var got = _.strFindAll( { src : 'this is hello from hell', ins : /hell/, fast : 1 } );
  var expected =
  [
    [ 8, 12, 0 ],
    [ 19, 23, 0 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp for numbers, flag "gm", three entries';
  var got = _.strFindAll( { src : '12345', ins : /[1-3]/gm, fast : 1 } );
  var expected =
  [
    [ 0, 1, 0 ],
    [ 1, 2, 0 ],
    [ 2, 3, 0 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - regexp for a few "a", entry';
  var got = _.strFindAll( { src : 'gpbaac', ins : /a+/, fast : 1 } );
  var expected = [ [ 3, 5, 0 ] ];
  test.identical( got, expected );

  test.case = 'ins - complex regexp, flag "gm"';
  var got = _.strFindAll( { src : 'gpbgpcgpd', ins : /(gp)+[^bc]$/gm, fast : 1 } );
  var expected = [ [ 6, 9, 0 ] ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, one entry';
  var got = _.strFindAll( { src : 'gpa', ins : [ /^d/, /p$/, /a/ ], fast : 1 } );
  var expected = [ [ 2, 3, 2 ] ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps, flag "gm", two entries';
  var got = _.strFindAll( { src : 'gpahpb', ins : [ /a/, /b/gm ], fast : 1 } );
  var expected =
  [
    [ 2, 3, 0 ],
    [ 5, 6, 1 ]
  ];
  test.identical( got, expected );

  test.case = 'ins - array of regexps and strings, flag "gm", entries';
  var got = _.strFindAll( { src : 'gpahpb', ins : [ /a/gm, 'f', /k$/, 'b' ], fast : 1 } );
  var expected =
  [
    [ 2, 3, 0 ],
    [ 5, 6, 3 ]
  ];
  test.identical( got, expected );

  test.close( 'ins - regexp, fast - 1' );

  /* - */

  test.open( 'ins - map, fast - 0' );

  test.case = 'map';
  var map = { manyA : /a+/, ba : 'ba' };
  var got = _.strFindAll( 'aabaa', map );
  var expected =
  [
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 0, 2 ],
      counter : 0,
      input : 'aabaa',
      tokenName : 'manyA'
    },
    {
      groups : [],
      match : 'ba',
      tokenId : 1,
      charsRangeLeft : [ 2, 4 ],
      counter : 1,
      input : 'aabaa',
      tokenName : 'ba'
    },
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 4, 5 ],
      counter : 2,
      input : 'aabaa',
      tokenName : 'manyA'
    }
  ];
  test.identical( got, expected );

  /* */

  test.case = 'ins - map, tokenizingUnknwon - 1, but not unknown';
  var map = { manyA : /a+/, ba : 'ba' };
  var got = _.strFindAll
  ({
    src : 'aabaa',
    ins : map,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 0, 2 ],
      counter : 0,
      input : 'aabaa',
      tokenName : 'manyA'
    },
    {
      groups : [],
      match : 'ba',
      tokenId : 1,
      charsRangeLeft : [ 2, 4 ],
      counter : 1,
      input : 'aabaa',
      tokenName : 'ba'
    },
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 4, 5 ],
      counter : 2,
      input : 'aabaa',
      tokenName : 'manyA'
    }
  ]
  test.identical( got, expected );

  /* */

  test.case = 'map with tokenizingUnknwon - 1 and unknown';
  var map = { manyA : /a+/, ba : 'ba' };
  var got = _.strFindAll
  ({
    src : 'xaabaazb',
    ins : map,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    {
      match : 'x',
      groups : [],
      tokenId : -1,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : 'xaabaazb',
    },
    {
      match : 'aa',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 1, 3 ],
      counter : 1,
      input : 'xaabaazb',
      tokenName : 'manyA',
    },
    {
      match : 'ba',
      groups : [],
      tokenId : 1,
      charsRangeLeft : [ 3, 5 ],
      counter : 2,
      input : 'xaabaazb',
      tokenName : 'ba'
    },
    {
      match : 'a',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 5, 6 ],
      counter : 3,
      input : 'xaabaazb',
      tokenName : 'manyA'
    },
    {
      match : 'zb',
      groups : [],
      tokenId : -1,
      charsRangeLeft : [ 6, 8 ],
      counter : 4,
      input : 'xaabaazb',
    },
  ];
  test.identical( got, expected );

  /* */

  test.case = 'ins - array of regexps, counter - 1';
  var o =
  {
    src : '**',
    ins :
    [
      /\./g,
      /([!?*@+]+)\((.*?(?:\|(.*?))*)\)/g,
      /(\*\*\/|\*\*)/g,
      /(\*)/g,
      /(\?)/g
    ],
    fast : 0,
    counter : 1,
  }
  var got = _.strFindAll( o );
  var expected =
  [
    {
      match : '**',
      groups : [ '**' ],
      tokenId : 2,
      charsRangeLeft : [ 0, 2 ],
      counter : 1,
      input : '**',
    }
  ];
  test.identical( got, expected );

  test.close( 'ins - map, fast - 0' );

  /* - */

  test.open( 'ins - map, fast - 1' );

  test.case = 'map';
  var map = { manyA : /a+/, ba : 'ba' };
  var got = _.strFindAll( { src : 'aabaa', ins : map, fast : 1 } );
  var expected =
  [
    [ 0, 2, 0 ],
    [ 2, 4, 1 ],
    [ 4, 5, 0 ]
  ];
  test.identical( got, expected );

  /* */

  test.case = 'ins - map, tokenizingUnknwon - 1, but not unknown';
  var map = { manyA : /a+/, ba : 'ba' };
  var got = _.strFindAll
  ({
    src : 'aabaa',
    ins : map,
    fast : 1,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    [ 0, 2, 0 ],
    [ 2, 4, 1 ],
    [ 4, 5, 0 ]
  ]
  test.identical( got, expected );

  /* */

  test.case = 'map with tokenizingUnknwon : 1 and unknown';
  var map = { manyA : /a+/, ba : 'ba' };
  var got = _.strFindAll
  ({
    src : 'xaabaazb',
    ins : map,
    fast : 1,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    [ 0, 1, -1 ],
    [ 1, 3, 0 ],
    [ 3, 5, 1 ],
    [ 5, 6, 0 ],
    [ 6, 8, -1 ]
  ];
  test.identical( got, expected );

  /* */

  test.case = 'ins - array of regexps, counter - 1';
  var o =
  {
    src : '**',
    ins :
    [
      /\./g,
      /([!?*@+]+)\((.*?(?:\|(.*?))*)\)/g,
      /(\*\*\/|\*\*)/g,
      /(\*)/g,
      /(\?)/g
    ],
    fast : 1,
    counter : 1,
  }
  var got = _.strFindAll( o );
  var expected = [ [ 0, 2, 2 ] ];
  test.identical( got, expected );

  test.close( 'ins - map, fast - 1' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strFindAll() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strFindAll( '1', '2', '3' ) );

  test.case = 'single argument is not a map';
  test.shouldThrowErrorSync( () => _.strFindAll( '1' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strFindAll( 1, '2' ) );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.strFindAll( '1', 2 ) );

  test.case = 'unknown option in map options';
  test.shouldThrowErrorSync( () => _.strFindAll( { dst : 'gpx', dictionary : [ 'a', 'b' ] } ) );

  test.close( 'throwing' );
}

/*
  qqq2 : extend test routine strFindAllValueWithLong | Dmytro : extended by new test cases, option fast uses
*/

function strFindAllValueWithLong( test )
{
  test.open( 'ins - map, fast - 0' );

  test.case = 'gpahpb, found none';
  var map = { 'a' : [ 'x' ] };
  var got = _.strFindAll( 'gpahpb', map );
  var exp = [];
  test.identical( got, exp );

  /* */

  test.case = 'trivial';
  var map = { a : 'some', b : [ 'string1', 'string2' ] };
  var got = _.strFindAll( 'some string2 text', map );
  var exp =
  [
    {
      'match' : 'some',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 4 ],
      'counter' : 0,
      'input' : 'some string2 text',
      'tokenName' : 'a'
    },
    {
      'match' : 'string2',
      'groups' : [],
      'tokenId' : 2,
      'charsRangeLeft' : [ 5, 12 ],
      'counter' : 1,
      'input' : 'some string2 text',
      'tokenName' : 'b_string2'
    }
  ];
  test.identical( got, exp );

  /* */

  test.case = 'gpahpb, found single';
  var map = { 'a' : [ 'g' ] };
  var got = _.strFindAll( 'gpahpb', map );
  var exp =
  [
    {
      'match' : 'g',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 0, 1 ],
      'counter' : 0,
      'input' : 'gpahpb',
      'tokenName' : 'a_g'
    }
  ]
  test.identical( got, exp );

  /* */

  test.case = 'gpahpb, found several';
  var map = { 'a' : [ 'p' ] };
  var got = _.strFindAll( 'gpahpb', map );
  var exp =
  [
    {
      'match' : 'p',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 1, 2 ],
      'counter' : 0,
      'input' : 'gpahpb',
      'tokenName' : 'a_p'
    },
    {
      'match' : 'p',
      'groups' : [],
      'tokenId' : 0,
      'charsRangeLeft' : [ 4, 5 ],
      'counter' : 1,
      'input' : 'gpahpb',
      'tokenName' : 'a_p'
    }
  ]
  test.identical( got, exp );

  test.case = 'map';
  var map = { manyA : /a+/, ba : [ 'ba', /ba/ ] };
  var got = _.strFindAll( 'aabaa', map );
  var expected =
  [
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 0, 2 ],
      counter : 0,
      input : 'aabaa',
      tokenName : 'manyA'
    },
    {
      groups : [],
      match : 'ba',
      tokenId : 1,
      charsRangeLeft : [ 2, 4 ],
      counter : 1,
      input : 'aabaa',
      tokenName : 'ba_ba'
    },
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 4, 5 ],
      counter : 2,
      input : 'aabaa',
      tokenName : 'manyA'
    }
  ];
  test.identical( got, expected );

  /* */

  test.case = 'ins - map, tokenizingUnknwon - 1, but not unknown';
  var map = { manyA : /a+/, ba : [ 'ba', /ba/ ] };
  var got = _.strFindAll
  ({
    src : 'aabaa',
    ins : map,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    {
      groups : [],
      match : 'aa',
      tokenId : 0,
      charsRangeLeft : [ 0, 2 ],
      counter : 0,
      input : 'aabaa',
      tokenName : 'manyA'
    },
    {
      groups : [],
      match : 'ba',
      tokenId : 1,
      charsRangeLeft : [ 2, 4 ],
      counter : 1,
      input : 'aabaa',
      tokenName : 'ba_ba'
    },
    {
      groups : [],
      match : 'a',
      tokenId : 0,
      charsRangeLeft : [ 4, 5 ],
      counter : 2,
      input : 'aabaa',
      tokenName : 'manyA'
    }
  ]
  test.identical( got, expected );

  /* */

  test.case = 'map with tokenizingUnknwon - 1 and unknown';
  var map = { manyA : /a+/, ba : [ 'ba', /ba/ ] };
  var got = _.strFindAll
  ({
    src : 'xaabaazb',
    ins : map,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    {
      match : 'x',
      groups : [],
      tokenId : -1,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : 'xaabaazb',
    },
    {
      match : 'aa',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 1, 3 ],
      counter : 1,
      input : 'xaabaazb',
      tokenName : 'manyA',
    },
    {
      match : 'ba',
      groups : [],
      tokenId : 1,
      charsRangeLeft : [ 3, 5 ],
      counter : 2,
      input : 'xaabaazb',
      tokenName : 'ba_ba'
    },
    {
      match : 'a',
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 5, 6 ],
      counter : 3,
      input : 'xaabaazb',
      tokenName : 'manyA'
    },
    {
      match : 'zb',
      groups : [],
      tokenId : -1,
      charsRangeLeft : [ 6, 8 ],
      counter : 4,
      input : 'xaabaazb',
    },
  ];
  test.identical( got, expected );

  test.close( 'ins - map, fast - 0' );

  /* - */

  test.open( 'ins - map, fast - 1' );

  test.case = 'gpahpb, found none';
  var got = _.strFindAll( { src : 'gpahpb', ins : { 'a' : [ 'x' ] }, fast : 1 } );
  var exp = [];
  test.identical( got, exp );

  /* */

  test.case = 'trivial';
  var map = { a : 'some', b : [ 'string1', 'string2' ] };
  var got = _.strFindAll( { src : 'some string2 text', ins : map, fast : 1 } );
  var exp =
  [
    [ 0, 4, 0 ],
    [ 5, 12, 2 ],
  ];
  test.identical( got, exp );

  /* */

  test.case = 'gpahpb, found single';
  var map = { 'a' : [ 'g' ] };
  var got = _.strFindAll( { src : 'gpahpb', ins : map, fast : 1 } );
  var exp = [ [ 0, 1, 0 ] ];
  test.identical( got, exp );

  /* */

  test.case = 'gpahpb, found several';
  var map = { 'a' : [ 'p' ] };
  var got = _.strFindAll( { src : 'gpahpb', ins : map, fast : 1 } );
  var exp =
  [
    [ 1, 2, 0 ],
    [ 4, 5, 0 ],
  ];
  test.identical( got, exp );

  test.case = 'map';
  var map = { manyA : /a+/, ba : [ 'ba', /ba/ ] };
  var got = _.strFindAll( { src : 'aabaa', ins : map, fast : 1 } );
  var expected =
  [
    [ 0, 2, 0 ],
    [ 2, 4, 1 ],
    [ 4, 5, 0 ]
  ];
  test.identical( got, expected );

  /* */

  test.case = 'ins - map, tokenizingUnknwon - 1, but not unknown';
  var map = { manyA : /a+/, ba : [ 'ba', /ba/ ] };
  var got = _.strFindAll
  ({
    src : 'aabaa',
    ins : map,
    fast : 1,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    [ 0, 2, 0 ],
    [ 2, 4, 1 ],
    [ 4, 5, 0 ]
  ]
  test.identical( got, expected );

  /* */

  test.case = 'map with tokenizingUnknwon : 1 and unknown';
  var map = { manyA : /a+/, ba : [ 'ba', /ba/ ] };
  var got = _.strFindAll
  ({
    src : 'xaabaazb',
    ins : map,
    fast : 1,
    tokenizingUnknown : 1,
  });
  var expected =
  [
    [ 0, 1, -1 ],
    [ 1, 3, 0 ],
    [ 3, 5, 1 ],
    [ 5, 6, 0 ],
    [ 6, 8, -1 ]
  ];
  test.identical( got, expected );

  test.close( 'ins - map, fast - 1' );
}

strFindAllValueWithLong.description =
`
  - tokens definition with array in value produce proper list of tokens
`

//

function tokensSyntaxFrom( test )
{

  test.case = 'ins - instance of _.TokensSyntax';
  var src = _.TokensSyntax.apply( null, [] );
  var got = _.tokensSyntaxFrom( src );
  var exp = _.TokensSyntax.apply( null, [] );
  test.identical( got, exp );
  test.is( got === src );

  test.case = 'ins - instance of _.TokensSyntax maked by tokensSyntaxFrom';
  var src = _.tokensSyntaxFrom( 'src' );
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'src' ],
    idToName : [],
    nameToId : {},
    alternatives : {},
  };
  test.equivalent( got, exp );
  test.is( got === src );

  /* */

  test.case = 'ins - empty string';
  var src = '';
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ '' ],
    idToName : [],
    nameToId : {},
    alternatives : {},
  };
  test.equivalent( got, exp );

  test.case = 'ins - string';
  var src = 'src';
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'src' ],
    idToName : [],
    nameToId : {},
    alternatives : {},
  };
  test.equivalent( got, exp );

  /* */

  test.case = 'ins - empty array';
  var src = [];
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [],
    idToName : [],
    nameToId : {},
    alternatives : {},
  };
  test.equivalent( got, exp );

  test.case = 'ins - array with tokens';
  var src = [ 'abc', /^[abc]/ ];
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'abc', /^[abc]/ ],
    idToName : [],
    nameToId : {},
    alternatives : {},
  };
  test.equivalent( got, exp );

  /* */

  test.case = 'ins - empty map';
  var src = {};
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [],
    idToName : [],
    nameToId : {},
    alternatives : {},
  };
  test.equivalent( got, exp );

  test.case = 'ins - map with string tokens';
  var src = { a : 'abc', b : 'def', c : 'hig' };
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'abc', 'def', 'hig' ],
    idToName : [ 'a', 'b', 'c' ],
    nameToId : { a : 0, b : 1, c : 2 },
    alternatives : {},
  };
  test.equivalent( got, exp );

  test.case = 'ins - map with string tokens and empty array';
  var src = { d : [], b : 'def', a : 'abc', c : 'hig' };
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'def', 'abc', 'hig' ],
    idToName : [ 'b', 'a', 'c' ],
    nameToId : { b : 0, a : 1, c : 2 },
    alternatives : { d : [] },
  };
  test.equivalent( got, exp );

  test.case = 'ins - map with string tokens and filled array';
  var src = { d : [ 'a', 'b', 'c' ], b : 'def', a : 'abc', c : 'hig' };
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'a', 'b', 'c', 'def', 'abc', 'hig' ],
    idToName : [ 'd_a', 'd_b', 'd_c', 'b', 'a', 'c' ],
    nameToId : { d_a : 0, d_b : 1, d_c : 2, b : 3, a : 4, c : 5 },
    alternatives : { d : [ 'd_a', 'd_b', 'd_c' ] },
  };
  test.equivalent( got, exp );

  test.case = 'ins - map with string tokens and filled array, key and element of array - empty string';
  var src = { b : 'def', a : 'abc', c : 'hig', '' : [ 'a', '', 'c' ] };
  var got = _.tokensSyntaxFrom( src );
  var exp =
  {
    idToValue : [ 'def', 'abc', 'hig', 'a', '', 'c' ],
    idToName : [ 'b', 'a', 'c', '_a', '_', '_c',  ],
    nameToId : { b : 0, a : 1, c : 2, _a : 3, _ : 4, _c : 5 },
    alternatives : { '' : [ '_a', '_', '_c' ] },
  };
  test.equivalent( got, exp );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.tokensSyntaxFrom() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.tokensSyntaxFrom( 'a', 'b' ) );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.tokensSyntaxFrom( new U8x( [ 1, 2, 3 ] ) ) );

}

//

function strReplaceAllDefaultOptions( test )
{
  test.open( 'string' );

  test.case = 'src - empty, ins - empty, but - empty';
  var got = _.strReplaceAll( '', '', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - string, but - empty';
  var got = _.strReplaceAll( '', 'x', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - empty, but - string';
  var got = _.strReplaceAll( '', '', 'x' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - empty';
  var got = _.strReplaceAll( 'x', '', '' );
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - strings, no occurrences, returns origin';
  var got = _.strReplaceAll( 'hello', 'x', 'y' );
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src === ins, but - empty';
  var got = _.strReplaceAll( 'x', 'x', '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - string';
  var got = _.strReplaceAll( 'x', '', 'x' );
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - repeats in src, but - string';
  var got = _.strReplaceAll( 'ababab', 'ab', 'ac' );
  var expected = 'acacac';
  test.identical( got, expected );

  test.case = 'src - string, ins - char, but - char';
  var got = _.strReplaceAll( 'aabaa', 'b', 'c' );
  var expected = 'aacaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of strings, but - array of strings';
  var got = _.strReplaceAll( 'gpahpb', [ 'a', 'b' ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty map';
  var got = _.strReplaceAll( 'hello', {} );
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty array';
  var got = _.strReplaceAll( 'hello', [] );
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - map, no recursion should happen';
  var got = _.strReplaceAll( 'abcabc', { abc : 'a', a : 'b' } );
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll( 'abcabc', [ [ 'abc', 'a' ], [ 'a', 'b' ] ] );
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll( 'abcabc', [ [ 'a', 'b' ], [ 'abc', 'a' ] ] );
  var expected = 'bbcbbc';
  test.identical( got, expected );

  test.case = 'one argument call, map and dictionary';
  var got = _.strReplaceAll( { src : 'gpx', dictionary : { 'x' : 'a' } } );
  var expected = 'gpa';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - string, but - routine';
  var got = _.strReplaceAll( 'this is hello from hell', 'hell', ( e, it ) => 'paradise' );
  var expected = 'this is paradiseo from paradise';
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'src - empty, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll( '', /(?:)/gm, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - string, but - empty';
  var got = _.strReplaceAll( '', /x/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll( '', /(?:)/g, 'x' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll( 'x', /(?:)/g, '' );
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - regexp - empty string, no occurrences, returns origin';
  var got = _.strReplaceAll( 'hello', /x/, 'y' );
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - any symbols, but - empty';
  var got = _.strReplaceAll( 'x', /.*/, '' );
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll( 'x', /(?:)/gm, 'x' );
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - char, returns original';
  var got = _.strReplaceAll( 'aabaa', /(?:)/g, 'c' );
  var expected = 'aabaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - simple string, but - char, one entry';
  var got = _.strReplaceAll( 'aabaa', /b/gm, 'c' );
  var expected = 'aacaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - range of chars, but - char, three entries';
  var got = _.strReplaceAll( '12345', /[1-3]/gm, '0' );
  var expected = '00045';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - one and more, but - char, entry';
  var got = _.strReplaceAll( 'gpbaac', /a+/gm, 'b' );
  var expected = 'gpbbc';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - group and end, but - char, entry';
  var got = _.strReplaceAll( 'gpbgpcgpd', /(gp)+[^bc]$/gm, 'x' );
  var expected = 'gpbgpcx';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps, but - array of strings, three entries';
  var got = _.strReplaceAll( 'gpahpb', [ /a/gm, /b/gm ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps and strings, but - array of strings, three entries';
  var got = _.strReplaceAll( 'gpahpb', [ /a/gm, 'b' ], [ 'c', 'd' ] );
  var expected = 'gpchpd';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - regexp, but - routine';
  var got = _.strReplaceAll( 'this is hello from hell', /hell/g, ( e, it ) => 'paradise' );
  var expected = 'this is paradiseo from paradise';
  test.identical( got, expected );

  test.close( 'regexp' );

  /* - */

  if( !Config.debug )
  return;

  test.open( 'throwing' );

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strReplaceAll( ) );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strReplaceAll( '1', '2', '3', '4' ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strReplaceAll( 1, '2', '3') );

  test.case = 'wrong type of ins';
  test.shouldThrowErrorSync( () => _.strReplaceAll( '1', 2, '3') );

  test.case = 'wrong type of but';
  test.shouldThrowErrorSync( () => _.strReplaceAll( '1', '2', 3 ) );

  test.case = 'two arguments call, wrong type of dictionary';
  test.shouldThrowErrorSync( () => _.strReplaceAll( '1', 2 ) );

  test.case = 'single argument call, wrong type of options map';
  test.shouldThrowErrorSync( () => _.strReplaceAll( '1' ) );

  test.case = 'wrong type of dictionary value';
  test.shouldThrowErrorSync( () => _.strReplaceAll( { dst : 'gpx', dictionary : { 'a' : [ 1, 2 ] } } ) );
  test.shouldThrowErrorSync( () => _.strReplaceAll( 'gpahpb', [ 'a' ], [ 'c', 'd' ] ) );
  test.shouldThrowErrorSync( () => _.strReplaceAll( 'gpahpb', [ 'a', 'b' ], [ 'x' ] ) );
  test.shouldThrowErrorSync( () => _.strReplaceAll( 'gpahpb', { 'a' : [ 'x' ] } ) );

  test.close( 'throwing' );
}

//

function strReplaceAllOptionJoining( test )
{
  test.open( 'string' );

  test.case = 'src - empty, ins - empty, but - empty';
  var got = _.strReplaceAll( { src : '', dictionary : [ [ '', '' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - empty, ins - string, but - empty';
  var got = _.strReplaceAll( { src : '', dictionary : [ [ 'x', '' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - empty, ins - empty, but - string';
  var got = _.strReplaceAll( { src : '', dictionary : [ [ '', 'x' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - empty';
  var got = _.strReplaceAll( { src : 'x', dictionary : [ [ '', '' ] ], joining : 0 } );
  var expected = [ 'x' ];
  test.identical( got, expected );

  test.case = 'src, ins and but - strings, no occurrences, returns origin';
  var got = _.strReplaceAll( { src : 'hello', dictionary : [ [ 'x', 'y' ] ], joining : 0 } );
  var expected = [ 'hello' ];
  test.identical( got, expected );

  test.case = 'src === ins, but - empty';
  var got = _.strReplaceAll( { src : 'x', dictionary : [ [ 'x', '' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - string';
  var got = _.strReplaceAll( { src : 'x', dictionary : [ [ '', 'x' ] ], joining : 0 } );
  var expected = [ 'x' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - repeats in src, but - string';
  var got = _.strReplaceAll( { src : 'ababab', dictionary : [ [ 'ab', 'ac' ] ], joining : 0 } );
  var expected = [ 'ac', 'ac', 'ac', '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - char, but - char';
  var got = _.strReplaceAll( { src : 'aabaa', dictionary : [ [ 'b', 'c' ] ], joining : 0 } );
  var expected = [ 'aa', 'c', 'aa' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - array of strings, but - array of strings';
  var got = _.strReplaceAll( { src : 'gpahpb', dictionary : [ [ 'a', 'b' ], [ 'c', 'd' ] ], joining : 0 } );
  var expected = [ 'gp', 'b', 'hpb' ];
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty map';
  var got = _.strReplaceAll( { src : 'hello', dictionary : {}, joining : 0 } );
  var expected = [ 'hello' ];
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty array';
  var got = _.strReplaceAll( { src : 'hello', dictionary : [], joining : 0 } );
  var expected = [ 'hello' ];
  test.identical( got, expected );

  test.case = 'src - string, dictionary - map, no recursion should happen';
  var got = _.strReplaceAll( { src : 'abcabc', dictionary : { abc : 'a', a : 'b' }, joining : 0 } );
  var expected = [ 'a', 'a', '' ];
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll( { src : 'abcabc', dictionary : [ [ 'abc', 'a' ], [ 'a', 'b' ] ], joining : 0 } );
  var expected = [ 'a', 'a', '' ];
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll( { src : 'abcabc', dictionary : [ [ 'a', 'b' ], [ 'abc', 'a' ] ], joining : 0 } );
  var expected = [ 'b', 'bc', 'b', 'bc' ];
  test.identical( got, expected );

  test.case = 'one argument call, map and dictionary';
  var got = _.strReplaceAll( { src : 'gpx', dictionary : { 'x' : 'a' }, joining : 0 } );
  var expected = [ 'gp', 'a', '' ];
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - string, but - routine';
  var got = _.strReplaceAll( { src : 'this is hello from hell', dictionary : [ [ 'hell', ( e, it ) => 'paradise' ] ], joining : 0 } );
  var expected = [ 'this is ', 'paradise', 'o from ', 'paradise', '' ];
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'src - empty, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll( { src : '', dictionary : [ [ /(?:)/gm, '' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - string, but - empty';
  var got = _.strReplaceAll( { src : '', dictionary : [ [ /x/, '' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll( { src : '', dictionary : [ [ /(?:)/g, 'x' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll( { src : 'x', dictionary : [ [ /(?:)/g, '' ] ], joining : 0 } );
  var expected = [ 'x' ];
  test.identical( got, expected );

  test.case = 'src, ins and but - regexp - empty string, no occurrences, returns origin';
  var got = _.strReplaceAll( { src : 'hello', dictionary : [ [ /x/, 'y' ] ], joining : 0 } );
  var expected = [ 'hello' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - any symbols, but - empty';
  var got = _.strReplaceAll( { src : 'x', dictionary : [ [ /.*/, '' ] ], joining : 0 } );
  var expected = [ '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll( { src : 'x', dictionary : [ [ /(?:)/gm, 'x' ] ], joining : 0 } );
  var expected = [ 'x' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - char, returns original';
  var got = _.strReplaceAll( { src : 'aabaa', dictionary : [ [ /(?:)/g, 'c' ] ], joining : 0 } );
  var expected = [ 'aabaa' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - simple string, but - char, one entry';
  var got = _.strReplaceAll( { src : 'aabaa', dictionary : [ [ /b/gm, 'c' ] ], joining : 0 } );
  var expected = [ 'aa', 'c', 'aa' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - range of chars, but - char, three entries';
  var got = _.strReplaceAll( { src : '12345', dictionary : [ [ /[1-3]/gm, '0' ] ], joining : 0 } );
  var expected = [ '0', '0', '0', '45' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - one and more, but - char, entry';
  var got = _.strReplaceAll( { src : 'gpbaac', dictionary : [ [ /a+/gm, 'b' ] ], joining : 0 } );
  var expected = [ 'gpb', 'b', 'c' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - group and end, but - char, entry';
  var got = _.strReplaceAll( { src : 'gpbgpcgpd', dictionary : [ [ /(gp)+[^bc]$/gm, 'x' ] ], joining : 0 } );
  var expected = [ 'gpbgpc', 'x', '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps, but - array of strings, three entries';
  var got = _.strReplaceAll( { src : 'gpahpb', dictionary : [ [ [ /a/gm, /b/gm ], [ 'c', 'd' ] ] ], joining : 0 } );
  var expected = [ 'gp', 'c', 'hp', 'd', '' ];
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps and strings, but - array of strings, three entries';
  var got = _.strReplaceAll( { src : 'gpahpb', dictionary : [ [ [ /a/gm, 'b' ], [ 'c', 'd' ] ] ], joining : 0 } );
  var expected = [ 'gp', 'c', 'hp', 'd', '' ];
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - regexp, but - routine';
  var got = _.strReplaceAll( { src : 'this is hello from hell', dictionary : [ [ /hell/g, ( e, it ) => 'paradise' ] ], joining : 0 } );
  var expected = [ 'this is ', 'paradise', 'o from ', 'paradise', '' ];
  test.identical( got, expected );

  test.close( 'regexp' );
}

//

function strReplaceAllOptionOnUnknown( test )
{
  test.open( 'onUnknown returns empty string' );

  test.open( 'string' );

  test.case = 'src - empty, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - strings, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ 'x', 'y' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src === ins, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - repeats in src, but - string';
  var got = _.strReplaceAll
  ({
    src : 'ababab',
    dictionary : [ [ 'ab', 'ac' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'acacac';
  test.identical( got, expected );

  test.case = 'src - string, ins - char, but - char';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ 'b', 'c' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'caa';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of strings, but - array of strings';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ 'a', 'b' ], [ 'c', 'd' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'bhpb';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty map';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : {},
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty array';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - map, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : { abc : 'a', a : 'b' },
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'abc', 'a' ], [ 'a', 'b' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'a', 'b' ], [ 'abc', 'a' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'bbbc';
  test.identical( got, expected );

  test.case = 'one argument call, map and dictionary';
  var got = _.strReplaceAll
  ({
    src : 'gpx',
    dictionary : { 'x' : 'a' },
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'a';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - string, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ 'hell', ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'paradiseparadise';
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'src - empty, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/gm, '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /x/, '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/g, 'x' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/g, '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - regexp - empty string, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ /x/, 'y' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - any symbols, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /.*/, '' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - char, returns original';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /(?:)/g, 'c' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'aabaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - simple string, but - char, one entry';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /b/gm, 'c' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'caa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - range of chars, but - char, three entries';
  var got = _.strReplaceAll
  ({
    src : '12345',
    dictionary : [ [ /[1-3]/gm, '0' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = '00045';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - one and more, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbaac',
    dictionary : [ [ /a+/gm, 'b' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'bc';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - group and end, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbgpcgpd',
    dictionary : [ [ /(gp)+[^bc]$/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, /b/gm ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'cd';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps and strings, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, 'b' ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'cd';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - regexp, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ /hell/g, ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => ''
  });
  var expected = 'paradiseparadise';
  test.identical( got, expected );

  test.close( 'regexp' );

  test.close( 'onUnknown returns empty string' );

  /* - */

  test.open( 'onUnknown returns element' );

  test.open( 'string' );

  test.case = 'src - empty, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - strings, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ 'x', 'y' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src === ins, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - repeats in src, but - string';
  var got = _.strReplaceAll
  ({
    src : 'ababab',
    dictionary : [ [ 'ab', 'ac' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'acacac';
  test.identical( got, expected );

  test.case = 'src - string, ins - char, but - char';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ 'b', 'c' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'aacaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of strings, but - array of strings';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ 'a', 'b' ], [ 'c', 'd' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'gpbhpb';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty map';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : {},
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty array';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - map, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : { abc : 'a', a : 'b' },
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'abc', 'a' ], [ 'a', 'b' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'a', 'b' ], [ 'abc', 'a' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'bbcbbc';
  test.identical( got, expected );

  test.case = 'one argument call, map and dictionary';
  var got = _.strReplaceAll
  ({
    src : 'gpx',
    dictionary : { 'x' : 'a' },
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'gpa';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - string, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ 'hell', ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'this is paradiseo from paradise';
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'src - empty, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/gm, '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /x/, '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/g, 'x' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/g, '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - regexp - empty string, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ /x/, 'y' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - any symbols, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /.*/, '' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - char, returns original';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /(?:)/g, 'c' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'aabaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - simple string, but - char, one entry';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /b/gm, 'c' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'aacaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - range of chars, but - char, three entries';
  var got = _.strReplaceAll
  ({
    src : '12345',
    dictionary : [ [ /[1-3]/gm, '0' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = '00045';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - one and more, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbaac',
    dictionary : [ [ /a+/gm, 'b' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'gpbbc';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - group and end, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbgpcgpd',
    dictionary : [ [ /(gp)+[^bc]$/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'gpbgpcx';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, /b/gm ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'gpchpd';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps and strings, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, 'b' ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'gpchpd';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - regexp, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ /hell/g, ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => e
  });
  var expected = 'this is paradiseo from paradise';
  test.identical( got, expected );

  test.close( 'regexp' );

  test.close( 'onUnknown returns element' );

  /* - */

  test.open( 'onUnknown returns element and tokenId' );

  test.open( 'string' );

  test.case = 'src - empty, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - strings, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ 'x', 'y' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src === ins, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - repeats in src, but - string';
  var got = _.strReplaceAll
  ({
    src : 'ababab',
    dictionary : [ [ 'ab', 'ac' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'acacac';
  test.identical( got, expected );

  test.case = 'src - string, ins - char, but - char';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ 'b', 'c' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'aa0caa';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of strings, but - array of strings';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ 'a', 'b' ], [ 'c', 'd' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'gp0bhpb';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty map';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : {},
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty array';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - map, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : { abc : 'a', a : 'b' },
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'abc', 'a' ], [ 'a', 'b' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'a', 'b' ], [ 'abc', 'a' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'bbc0bbc';
  test.identical( got, expected );

  test.case = 'one argument call, map and dictionary';
  var got = _.strReplaceAll
  ({
    src : 'gpx',
    dictionary : { 'x' : 'a' },
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'gp0a';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - string, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ 'hell', ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'this is 0paradiseo from 0paradise';
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'src - empty, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/gm, '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /x/, '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/g, 'x' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/g, '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - regexp - empty string, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ /x/, 'y' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - any symbols, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /.*/, '' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - char, returns original';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /(?:)/g, 'c' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'aabaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - simple string, but - char, one entry';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /b/gm, 'c' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'aa0caa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - range of chars, but - char, three entries';
  var got = _.strReplaceAll
  ({
    src : '12345',
    dictionary : [ [ /[1-3]/gm, '0' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = '00045';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - one and more, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbaac',
    dictionary : [ [ /a+/gm, 'b' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'gpb0bc';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - group and end, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbgpcgpd',
    dictionary : [ [ /(gp)+[^bc]$/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'gpbgpc0x';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, /b/gm ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'gp0chp1d';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps and strings, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, 'b' ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'gp0chp1d';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - regexp, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ /hell/g, ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => e + cont.tokenId
  });
  var expected = 'this is 0paradiseo from 0paradise';
  test.identical( got, expected );

  test.close( 'regexp' );

  test.close( 'onUnknown returns element and tokenId' );

  /* - */

  test.open( 'onUnknown returns element and map ins[ 0 ]' );

  test.open( 'string' );

  test.case = 'src - empty, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - strings, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ 'x', 'y' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src === ins, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ 'x', '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - empty, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ '', 'x' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - repeats in src, but - string';
  var got = _.strReplaceAll
  ({
    src : 'ababab',
    dictionary : [ [ 'ab', 'ac' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'acacac';
  test.identical( got, expected );

  test.case = 'src - string, ins - char, but - char';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ 'b', 'c' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'aabcaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of strings, but - array of strings';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ 'a', 'b' ], [ 'c', 'd' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'gpabhpb';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty map';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : {},
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - empty array';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - map, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : { abc : 'a', a : 'b' },
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'abc', 'a' ], [ 'a', 'b' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'aa';
  test.identical( got, expected );

  test.case = 'src - string, dictionary - array, no recursion should happen';
  var got = _.strReplaceAll
  ({
    src : 'abcabc',
    dictionary : [ [ 'a', 'b' ], [ 'abc', 'a' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'bbcabbc';
  test.identical( got, expected );

  test.case = 'one argument call, map and dictionary';
  var got = _.strReplaceAll
  ({
    src : 'gpx',
    dictionary : { 'x' : 'a' },
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'gpxa';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - string, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ 'hell', ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'this is hellparadiseo from hellparadise';
  test.identical( got, expected );

  test.close( 'string' );

  /* - */

  test.open( 'regexp' );

  test.case = 'src - empty, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/gm, '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - string, but - empty';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /x/, '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - empty, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : '',
    dictionary : [ [ /(?:)/g, 'x' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/g, '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src, ins and but - regexp - empty string, no occurrences, returns origin';
  var got = _.strReplaceAll
  ({
    src : 'hello',
    dictionary : [ [ /x/, 'y' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'hello';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - any symbols, but - empty';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /.*/, '' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - string';
  var got = _.strReplaceAll
  ({
    src : 'x',
    dictionary : [ [ /(?:)/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'x';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - empty string, but - char, returns original';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /(?:)/g, 'c' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'aabaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - simple string, but - char, one entry';
  var got = _.strReplaceAll
  ({
    src : 'aabaa',
    dictionary : [ [ /b/gm, 'c' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'aa/b/gmcaa';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - range of chars, but - char, three entries';
  var got = _.strReplaceAll
  ({
    src : '12345',
    dictionary : [ [ /[1-3]/gm, '0' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = '00045';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - one and more, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbaac',
    dictionary : [ [ /a+/gm, 'b' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'gpb/a+/gmbc';
  test.identical( got, expected );

  test.case = 'src - string, ins - regexp - group and end, but - char, entry';
  var got = _.strReplaceAll
  ({
    src : 'gpbgpcgpd',
    dictionary : [ [ /(gp)+[^bc]$/gm, 'x' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'gpbgpc/(gp)+[^bc]$/gmx';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, /b/gm ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'gp/a/gmchp/a/gmd';
  test.identical( got, expected );

  test.case = 'src - string, ins - array of regexps and strings, but - array of strings, three entries';
  var got = _.strReplaceAll
  ({
    src : 'gpahpb',
    dictionary : [ [ [ /a/gm, 'b' ], [ 'c', 'd' ] ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'gp/a/gmchp/a/gmd';
  test.identical( got, expected );

  /* */

  test.case = 'src - string, ins - regexp, but - routine';
  var got = _.strReplaceAll
  ({
    src : 'this is hello from hell',
    dictionary : [ [ /hell/g, ( e, it ) => 'paradise' ] ],
    onUnknown : ( e, cont, map ) => e + map.ins[ 0 ]
  });
  var expected = 'this is /hell/gparadiseo from /hell/gparadise';
  test.identical( got, expected );

  test.close( 'regexp' );

  test.close( 'onUnknown returns element and map ins[ 0 ]' );
}

//

function strTokenizeJs( test )
{

  function log( src )
  {
    logger.log( _.toStr( src, { levels : 3 } ) );
  }

  /* - */

  test.case = 'single line comment';

  var code = `
// type : 'image/png',
`;

  var expected =
  [
    {
      match : '\n',
      groups : [],
      tokenId : 5,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : code,
      tokenName : 'whitespace'
    },
    {
      match : `// type : 'image/png',`,
      groups : [],
      tokenId : 1,
      charsRangeLeft : [ 1, 23 ],
      counter : 1,
      input : code,
      tokenName : 'comment/singleline'
    },
    {
      match : '\n',
      groups : [],
      tokenId : 5,
      charsRangeLeft : [ 23, 24 ],
      counter : 2,
      input : code,
      tokenName : 'whitespace'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( select( got, '*/tokenName' ) );
  log( got );
  test.identical( got, expected );

  test.case = 'single line comment';

  var code =
` // divide by zero`

  var expected =
  [
    {
      match : ' ',
      groups : [],
      tokenId : 5,
      charsRangeLeft : [ 0, 1 ],
      counter : 0,
      input : ' // divide by zero',
      tokenName : 'whitespace'
    },
    {
      match : '// divide by zero',
      groups : [],
      tokenId : 1,
      charsRangeLeft : [ 1, 18 ],
      counter : 1,
      input : ' // divide by zero',
      tokenName : 'comment/singleline'
    }
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( select( got, '*/tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  test.case = 'single line comment inside long text looking like regexp';

  var code =
  `
for( var p = 0,pl = polygon.length / 2; p < pl ; p++ )
  // type : 'image/png',
`;

  var got = _.strTokenizeJs({ src : code, tokenizingUnknown : 1 });

  log( code );
  log( _.toStr( select( got, '*/match' ), { multiline : 0 } ) );
  log( select( got, '*/tokenName' ) );

  var tokenNamesGot = select( got, '*/tokenName' );
  var tokenNamesExpected = [ 'whitespace', 'keyword', 'parenthes', 'whitespace', 'keyword', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'whitespace', 'parenthes', 'whitespace', 'comment/singleline', 'whitespace' ];
  test.identical( tokenNamesGot, tokenNamesExpected );

  var matchesGot = select( got, '*/match' );
  var matchesExpected = [ '\n', 'for', '(', ' ', 'var', ' ', 'p', ' ', '=', ' ', '0', ',', 'pl', ' ', '=', ' ', 'polygon', '.', 'length', ' ', '/', ' ', '2', ';', ' ', 'p', ' ', '<', ' ', 'pl', ' ', ';', ' ', 'p', '++', ' ', ')', '\n  ', '// type : \'image/png\',', '\n' ];
  test.identical( matchesGot, matchesExpected );

  /* - */

  test.case = 'multiline comment';

  var code =
`
  /**
   * @file File.js.
   */
`

  var expected =
  [
    {
      match : '\n  ',
      groups : [],
      tokenId : 5,
      charsRangeLeft : [ 0, 3 ],
      counter : 0,
      input : code,
      tokenName : 'whitespace'
    },
    {
      match : `/**
   * @file File.js.
   */`,
      groups : [],
      tokenId : 0,
      charsRangeLeft : [ 3, 32 ],
      counter : 1,
      input : code,
      tokenName : 'comment/multiline'
    },
    {
      match : '\n',
      groups : [],
      tokenId : 5,
      charsRangeLeft : [ 32, 33 ],
      counter : 2,
      input : code,
      tokenName : 'whitespace'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( select( got, '*/tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  test.case = 'regular experssion without flags';

  var code = `/\d+/`;

  var expected =
  [
    {
      match : '/\d+/',
      groups : [ '\d+', '' ],
      tokenId : 7,
      charsRangeLeft : [ 0, 4 ],
      counter : 0,
      input : code,
      tokenName : 'regexp'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( select( got, '*/tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  test.case = 'regular experssion with flags';

  var code = `/\d+/ig`;

  var expected =
  [
    {
      match : '/\d+/ig',
      groups : [ '\d+', 'ig' ],
      tokenId : 7,
      charsRangeLeft : [ 0, 6 ],
      counter : 0,
      input : code,
      tokenName : 'regexp'
    },
  ]

  var got = _.strTokenizeJs( code );

  log( code );
  log( select( got, '*/tokenName' ) );
  log( got );
  test.identical( got, expected );

  /* - */

  // test.case = 'looks like regexp, but not';
  //
  // var x = / 2 , y /;
  // var code = `for( var p = x / 2 , y / 2 ; p < pl ; p++ )`;
  //
  // debugger;
  // var got = _.strTokenizeJs({ src : code, tokenizingUnknown : 1 });
  //
  // log( code );
  // log( _.toStr( select( got, '*/match' ), { multiline : 0 } ) );
  // log( select( got, '*/tokenName' ) );
  //
  // debugger;
  //
  // var tokenNamesGot = select( got, '*/tokenName' );
  // var tokenNamesExpected = [ 'whitespace', 'keyword', 'parenthes', 'whitespace', 'keyword', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'name', 'whitespace', 'punctuation', 'whitespace', 'number', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'whitespace', 'punctuation', 'whitespace', 'name', 'punctuation', 'whitespace', 'parenthes', 'whitespace', 'comment/singleline', 'whitespace' ];
  // test.identical( tokenNamesGot, tokenNamesExpected );
  //
  // var matchesGot = select( got, '*/match' );
  // var matchesExpected = [ '\n', 'for', '(', ' ', 'var', ' ', 'p', ' ', '=', ' ', '0', ',', 'pl', ' ', '=', ' ', 'polygon', '.', 'length', ' ', '/', ' ', '2', ';', ' ', 'p', ' ', '<', ' ', 'pl', ' ', ';', ' ', 'p', '++', ' ', ')', '\n  ', '// type : \'image/png\',', '\n' ];
  // test.identical( matchesGot, matchesExpected );

}

//

function strSorterParse( test )
{
  var src;
  var fields;
  var expected;
  var got;

  /* */

  test.case = 'str without special characters';
  src = 'ab'
  expected = [];
  got = _.strSorterParse( src );

  /* */

  test.case = 'single pair';
  src = 'a>'
  expected = [ [ 'a', 1 ] ];
  got = _.strSorterParse( src );

  /* */

  test.case = 'src only';

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

  test.case = 'with fields';
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

  test.case = 'with fields';
  var fields = { a : 'a', b : 'b' };
  src = 'a>b>c>'
  test.shouldThrowErrorOfAnyKind( () => _.strSorterParse( src, fields ) );

  test.case = 'src must be str, fields must be objectLike';
  src = 'a>b';
  fields = [];
  test.shouldThrowErrorOfAnyKind( () => _.strSorterParse( src, fields ) );
}

// --
//
// --

function strMetricFormat( test )
{

  test.case = 'default options, number is integer';
  var got = _.strMetricFormat( '100m' );
  var expected = '100.0 ';
  test.identical( got,expected );
  test.notIdentical( got, '100 ' );

  test.case = 'default options, number is float';
  var got = _.strMetricFormat( 0.001, undefined );
  var expected = '1.0 m';
  test.identical( got,expected );
  test.notIdentical( got, '0.005 ' );

  test.case = 'number to million';
  var got = _.strMetricFormat( 1, { metric : 6 } );
  var expected = '1.0 M';
  test.identical( got,expected );
  test.notIdentical( got, '1000000 ' );

  test.case = 'number to milli';
  var got = _.strMetricFormat( 1, { metric : -3 } );
  var expected = '1.0 m';
  test.identical( got,expected );
  test.notIdentical( got, '0.001 ' );

  test.case = 'metric out of range';
  var got = _.strMetricFormat( 10, { metric : 25 } );
  var expected = '10.0 ';
  test.identical( got,expected );
  test.notIdentical( got, '10.0 y' );

  test.case = 'fixed : 0';
  var got = _.strMetricFormat( '1300', { fixed : 0 } );
  var expected = '1 k';
  test.identical( got,expected );

  var got = _.strMetricFormat( '0.005', { fixed : 0 } );
  var expected = '5 m';
  test.identical( got,expected );

  test.case = 'divisor only ';
  var got = _.strMetricFormat( '1000000', { divisor : 3 } );
  var expected = '1.0 M';
  test.identical( got,expected );

  var got = _.strMetricFormat( '3200000000', { divisor : 3 } );
  var expected = '3.2 G';
  test.identical( got,expected );

  var got = _.strMetricFormat( '2000', { divisor : 3 } );
  var expected = '2.0 k';
  test.identical( got,expected );

  var got = _.strMetricFormat( 0.000002, { divisor : 3 } );
  var expected = '2.0 μ';
  test.identical( got,expected );

  var got = _.strMetricFormat( 0.000000003, { divisor : 3 } );
  var expected = '3.0 n';
  test.identical( got,expected );

  var got = _.strMetricFormat( 0.002, { divisor : 3 } );
  var expected = '2.0 m';
  test.identical( got,expected );

  var got = _.strMetricFormat( 0.000001, { divisor : 3 } );
  var expected = '1.0 μ';
  test.identical( got,expected );

  test.case = 'divisor, thousand test';
  var got = _.strMetricFormat( '1000000', { divisor : 2, thousand:100 } );
  var expected = '1.0 M';
  test.identical( got,expected );

  var got = _.strMetricFormat( 0.000002, { divisor : 2, thousand:100 } );
  var expected = '2.0 μ';
  test.identical( got,expected );

  var got = _.strMetricFormat( 0.000001,{ divisor : 2, thousand:100 } );
  var expected = '1.0 μ';
  test.identical( got,expected );

  test.case = 'divisor, thousand,dimensions, metric test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3, metric: 1 } );
  var expected = '10.0 k';
  test.identical( got,expected );

  var got = _.strMetricFormat( '-0.0001', { divisor : 3, thousand : 10, dimensions : 3, metric: 0 } );
  var expected = '-100.0 μ';
  test.identical( got,expected );

  test.case = 'divisor, thousand, dimensions test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3 } );
  var expected = '10.0 h';
  test.identical( got,expected );

  var got = _.strMetricFormat( '0.0001', { divisor : 3, thousand : 10, dimensions : 3 } );
  var expected = '100.0 μ';
  test.identical( got,expected );

  test.case = 'divisor, thousand, dimensions, fixed test';
  var got = _.strMetricFormat( '10000', { divisor : 2, thousand : 10, dimensions : 3, fixed : 0 } );
  var expected = '10 h';
  test.identical( got,expected );

  test.case = 'o.metrics';
  var got = _.strMetricFormat( '10000', { metrics : { '3' : { name : 'kilo' , symbol : 'k' , word : 'thousand' }, range : [ 0, 30 ] } } );
  var expected = '10.0 k';
  test.identical( got,expected );

  var got = _.strMetricFormat( '0.0001', { divisor : 3, thousand : 10, dimensions : 3, fixed : 0 } );
  var expected = '100 μ';
  test.identical( got,expected );

  test.case = 'first arg is Not a Number';
  var got = _.strMetricFormat( '[a]', undefined );
  var expected = 'NaN ';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strMetricFormat() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strMetricFormat( '1', { fixed : 0 }, '3' ) );

  test.case = 'wrong first argument';
  test.shouldThrowErrorSync( () => _.strMetricFormat( null, { fixed : 1 } ) );
  test.shouldThrowErrorSync( () => _.strMetricFormat( undefined, { fixed : 1 } ) );
  test.shouldThrowErrorSync( () => _.strMetricFormat( { 1 : 1}, { fixed : 1 } ) );
  test.shouldThrowErrorSync( () => _.strMetricFormat( [ 1 ], { fixed : 1 } ) );

  test.case = 'wrong second argument';
  test.shouldThrowErrorSync( () => _.strMetricFormat( 1, 1 ) );
  test.shouldThrowErrorSync( () => _.strMetricFormat( 1, '0' ) );

  test.case = 'fixed out of range';
  test.shouldThrowErrorSync( () => _.strMetricFormat( '1300', { fixed : 21 } ) );

  test.case = 'fixed is not a number';
  test.shouldThrowErrorSync( () => _.strMetricFormat( '1300', { fixed : [ 1 ] } ) );
}

//

function strMetricFormatBytes( test )
{

  test.case = 'zero';
  var got = _.strMetricFormatBytes( 0 );
  var expected = '0.0 b';
  test.identical( got,expected );

  test.case = 'string zero';
  var got = _.strMetricFormatBytes( '0' );
  var expected = '0.0 b';
  test.identical( got,expected );

  test.case = 'string';
  var got = _.strMetricFormatBytes( '1000000' );
  var expected = '976.6 kb';
  test.identical( got,expected );

  test.case = 'default options';
  var got = _.strMetricFormatBytes( 1024 );
  var expected = '1.0 kb';
  test.identical( got,expected );

  test.case = 'default options';
  var got = _.strMetricFormatBytes( 2500 );
  var expected = '2.4 kb';
  test.identical( got,expected );

  test.case = 'fixed';
  var got = _.strMetricFormatBytes( 2500, { fixed : 0 } );
  var expected = '2 kb';
  test.identical( got,expected );

  test.case = 'invalid metric value';
  var got = _.strMetricFormatBytes( 2500 , { metric:4 } );
  var expected = '2500.0 b';
  test.identical( got,expected );

  test.case = 'divisor test';
  var got = _.strMetricFormatBytes( Math.pow(2,32) , { divisor:4, thousand: 1024 } );
  var expected = '4.0 Tb';
  test.identical( got,expected );


  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid first argument type';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strMetricFormatBytes( [ '1', '2', '3' ] );
  });

  test.case = 'invalid second argument type';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strMetricFormatBytes( 0, '0' );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strMetricFormatBytes();
  });

  test.case = 'fixed out of range';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strMetricFormatBytes( '1300', { fixed : 22 } );
  });

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strMetricFormatBytes() );

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strMetricFormatBytes( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strMetricFormatBytes( null ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strMetricFormatBytes( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strMetricFormatBytes( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strMetricFormatBytes( [] ) );

}

//

function strToBytes( test )
{

  test.case = 'simple string';
  var got = _.strToBytes( 'abcd' );
  var expected = new U8x ( [ 97, 98, 99, 100 ] );
  test.identical( got,expected );

  test.case = 'escaping';
  var got = _.strToBytes( '\u001bABC\n\t' );
  var expected = new U8x ( [ 27, 65, 66, 67, 10, 9 ] );
  test.identical( got,expected );

  test.case = 'zero length';
  var got = _.strToBytes( '' );
  var expected = new U8x ( [ ] );
  test.identical( got,expected );

  test.case = 'returns the typed-array';
  var got = _.strToBytes( 'abc' );
  var expected = got;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'invalid arguments count';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strToBytes( '1', '2' );
  });

  test.case = 'invalid argument type';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strToBytes( 0 );
  });

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function()
  {
    _.strToBytes();
  });

  test.case = 'argument is wrong';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strToBytes( [  ] );
  } );

  test.case = 'argument is wrong';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strToBytes( 13 );
  } );

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strToBytes() );

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strToBytes( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strToBytes( null ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strToBytes( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strToBytes( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strToBytes( [] ) );

}

//

function strTimeFormat( test )
{

  test.case = 'simple number';
  var got = _.strTimeFormat( 0 );
  var expected = '0.000 s';
  test.identical( got,expected );

  test.case = 'simple number';
  var got = _.strTimeFormat( 1000 );
  var expected = '1.000 s';
  test.identical( got,expected );

  test.case = 'simple number';
  var got = _.strTimeFormat( 1 );
  var expected = '1.000 ms';
  test.identical( got,expected );

  test.case = 'big number';
  var got = _.strTimeFormat( Math.pow( 4,7 ) );
  var expected = '16.384 s';
  test.identical( got,expected );

  test.case = 'very big number';
  var got = _.strTimeFormat( Math.pow( 13,13 ) );
  var expected = '302.875 Gs';
  test.identical( got,expected );

  // test.case = 'zero';
  // var got = _.strTimeFormat( 0 );
  // var expected = '0.000 ys';
  // test.identical( got,expected );

  test.case = 'from date';
  var d = new Date( 1,2,3 )
  var got = _.strTimeFormat( d );
  var expected = '-2.172 Gs';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat() );

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( null ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( [] ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( '24:00' ) );

}

//

function strTimeFormat( test )
{

  test.case = 'simple number';
  var got = _.strTimeFormat( 0 );
  var expected = '0.000 s';
  test.identical( got,expected );

  test.case = 'simple number';
  var got = _.strTimeFormat( 1000 );
  var expected = '1.000 s';
  test.identical( got,expected );

  test.case = 'simple number';
  var got = _.strTimeFormat( 1 );
  var expected = '1.000 ms';
  test.identical( got,expected );

  test.case = 'big number';
  var got = _.strTimeFormat( Math.pow( 4,7 ) );
  var expected = '16.384 s';
  test.identical( got,expected );

  test.case = 'very big number';
  var got = _.strTimeFormat( Math.pow( 13,13 ) );
  var expected = '302.875 Gs';
  test.identical( got,expected );

  // test.case = 'zero';
  // var got = _.strTimeFormat( 0 );
  // var expected = '0.000 ys';
  // test.identical( got,expected );

  test.case = 'from date';
  var d = new Date( 1,2,3 )
  var got = _.strTimeFormat( d );
  var expected = '-2.172 Gs';
  test.identical( got,expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat() );

  test.case = 'too many arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( 1,1 ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( null ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( undefined ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( {} ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( [] ) );

  test.case = 'bad arguments';
  test.shouldThrowErrorOfAnyKind( () => _.strTimeFormat( '24:00' ) );

}

//

function strStructureParseDefaultOptions( test )
{
  test.case = 'passed argument is string, does not affects by options';
  var src = '[number : 1 str : abc]';
  var expected = { '[number' : 1, 'str' : 'abc]' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  /* */

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 str : abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : 1 str : abc array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : '[1,abc]' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : '[ 1  , abc ]' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = '[]';
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = '[ 1, abc ]';
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = '[ 1  , abc ]';
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = '[ 1  ab cd ]';
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1 str : abc]';
  var expected = { '[number' : 1, 'str' : 'abc]' };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strStructureParse() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a' }, 'extra' ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.strStructureParse( [ [ 'src', 'a' ] ] ) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', delimeter : ' ' } ) );

  test.case = 'keyValDelimeter is empty string';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', keyValDelimeter : '' } ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : [] } ) );

  test.case = 'wrong type of keyValDelimeter';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', keyValDelimeter : 1 } ) );

  test.case = 'wrong type of entryDelimeter';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', entryDelimeter : 1 } ) );

  test.case = 'defaultStructure is not "array", "map", "string"';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', defaultStructure : 'hashmap' } ) );
}

//

function strStructureParseOptionKeyValDelimeter( test )
{
  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number :: 1 str :: abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number :: 1 str :: abc array :: [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number :: 1  str::abc array ::  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path::D::\\some\\path';
  var expected = { path : 'D::\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path::D"::\\some\\path';
  var expected = { 'path::D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path::"D::\\some\\path"';
  var expected = { path : 'D::\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path::D::\\some\\path';
  var expected = { path : 'D::\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path :: D :: \\some\\ path ';
  var expected = { path : 'D :: \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 :: v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 :: v1 v1 b2 b2 :: v2 v2 c3 c3 :: v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a :: 1 b :: 2a, c :: 3 a d :: 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc e : 5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number :: 1 str :: abc]';
  var expected = [ 'number', '::', 1, 'str', '::', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, keyValDelimeter : '::' } );
  test.identical( got, expected );
}

//

function strStructureParseOptionEntryDelimeter( test )
{
  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1, str : abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : 1, str : abc, array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1,  str:abc,array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1, b2 b2 : v2 v2, c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1', 'b2 b2' : 'v2 v2', 'c3 c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1, b : 2a, c : 3, a d : 4abc, e : 5, abc';
  var expected = { 'a' : 1, 'b' : '2a', 'c' : 3, 'a d' : '4abc', 'e' : '5, abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1 str : abc]';
  var expected = [ 'number', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',' } );
  test.identical( got, expected );
}

//

function strStructureParseOptionParsingArrays( test )
{
  test.open( 'default long left and right delimeters' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 str : abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : 1 str : abc array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1 str : abc]';
  var expected = [ 'number', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );

  test.close( 'default long left and right delimeters' );

  /* - */

  test.open( 'long left and right delimeters is empty string' );

  test.case = 'empty string';
  var src = '';
  var expected = [];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = [];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = [ 'some', 'string' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 str : abc';
  var expected = [ 'number', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : 1 str : abc array : [1,abc]';
  var expected = [ 'number', ':', 1, 'str', ':', 'abc', 'array', ':', '[1', 'abc]' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1  str:abc array :  [ 1  , abc ] ';
  var expected = [ 'number', ':', 1, 'str:abc', 'array', ':', '[', 1, 'abc', ']' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = [ 'path:D:\\some\\path' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = [ 'path:D:\\some\\path' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = [ 'path:D:\\some\\path' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = [ 'path:D:\\some\\path' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = [ 'path', ':', 'D', ':', '\\some\\', 'path' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = [ 'a1', 'a1', ':', 'v1', 'v1' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = [ 'a1', 'a1', ':', 'v1', 'v1', 'b2', 'b2', ':', 'v2', 'v2', 'c3', 'c3', ':', 'v3', 'v3' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = [ 'a', ':', 1, 'b', ':', '2a', 'c', ':', 3, 'a', 'd', ':', '4abc', 'e', ':', 5, 'abc' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [ '[]' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = [ '[', 1, 'abc', ']' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ '[', 1, 'abc', ']' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = [ '[', 1, 'ab', 'cd', ']' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1 str : abc]';
  var expected = [ '[number', ':', 1, 'str', ':', 'abc]' ];
  var got = _.strStructureParse( { src : src,parsingArrays : 1, longLeftDelimeter : '', longRightDelimeter : '' } );
  test.identical( got, expected );

  test.close( 'long left and right delimeters is empty string' );

  /* - */

  test.open( 'not default arrayElementsDelimeter' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 str : abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : 1 str : abc array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1 str : abc]';
  var expected = [ 'number', 1, 'str', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, arrayElementsDelimeter : [ ' ', ',', ':' ] } );
  test.identical( got, expected );

  test.close( 'not default arrayElementsDelimeter' );
}

//

function strStructureParseOptionQuoting( test )
{
  test.open( 'quoting - 0' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = '"some string"';
  var expected = '"some string"';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 "str" : abc';
  var expected = { number : 1, '"str"' : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : "1" str : abc array : [1,abc]';
  var expected = { number : '"1"', str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' "number" : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { '"number"' : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { '"path' : 'D":\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : '"D:\\some\\path"' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ "1", abc ]';
  var expected = [ '"1"', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , "abc" ] ';
  var expected = [ 1, '"abc"' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  "ab" cd ] ';
  var expected = [ 1, '"ab"', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '["number" : 1 str : abc]';
  var expected = [ '"number"', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.close( 'quoting - 0' );

  /* - */

  test.open( 'quoting - 1' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = '"some string"';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 "str" : abc';
  var expected = { number : 1, 'str' : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : "1" str : abc array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' "number" : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { 'number' : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ "1", abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , "abc" ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  "ab" cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '["number" : 1 str : abc]';
  var expected = [ 'number', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.close( 'quoting - 1' );
}

//

function strReplaceAll( test )
{
  test.open( 'quoting - 0' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = '"some string"';
  var expected = '"some string"';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 "str" : abc';
  var expected = { number : 1, '"str"' : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : "1" str : abc array : [1,abc]';
  var expected = { number : '"1"', str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' "number" : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { '"number"' : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { '"path' : 'D":\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : '"D:\\some\\path"' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ "1", abc ]';
  var expected = [ '"1"', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , "abc" ] ';
  var expected = [ 1, '"abc"' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  "ab" cd ] ';
  var expected = [ 1, '"ab"', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '["number" : 1 str : abc]';
  var expected = [ '"number"', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 0 } );
  test.identical( got, expected );

  test.close( 'quoting - 0' );

  /* - */

  test.open( 'quoting - 1' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = '"some string"';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 "str" : abc';
  var expected = { number : 1, 'str' : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : "1" str : abc array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' "number" : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { 'number' : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ "1", abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , "abc" ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  "ab" cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '["number" : 1 str : abc]';
  var expected = [ 'number', ':', 1, 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, quoting : 1 } );
  test.identical( got, expected );

  test.close( 'quoting - 1' );
}

//

function strStructureParseOptionToNumberMaybe( test )
{
  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number : 1 str : abc';
  var expected = { number : '1', str : 'abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, flat array in value';
  var src = 'number : 1 str : abc array : [1,abc]';
  var expected = { number : '1', str : 'abc', array : [ '1', 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { number : '1', str : 'abc', array : [ '1', 'abc' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path:"D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1 b2 b2 : v2 v2 c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1 b2', 'b2' : 'v2 v2 c3', 'c3' : 'v3 v3' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1 b : 2a, c : 3 a d : 4abc e : 5 abc';
  var expected = { 'a' : '1', 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1, abc ]';
  var expected = [ '1', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ '1', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab cd ] ';
  var expected = [ '1', 'ab', 'cd' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1 str : abc]';
  var expected = [ 'number', ':', '1', 'str', ':', 'abc' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, toNumberMaybe : 0 } );
  test.identical( got, expected );
}

//

function strStructureParseOptionDefaultStructure( test )
{
  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, defaultStructure : 'map' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1, defaultStructure : 'map' } );
  test.identical( got, expected );

  /* */

  test.case = 'empty string';
  var src = '';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, defaultStructure : 'array' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, defaultStructure : 'array' } );
  test.identical( got, expected );

  /* */

  test.case = 'empty string';
  var src = '';
  var expected = '';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, defaultStructure : 'string' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = '';
  var got = _.strStructureParse( { src : src, parsingArrays : 1, defaultStructure : 'string' } );
  test.identical( got, expected );
}

//

function strStructureParseOptionDepthForArrays( test )
{
  test.open( 'arrays, balanced brackets' );

  test.case = 'empty array';
  var src = '[]';
  var exp = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 0';
  var src = '[[[[]]],[[[[]]]],[]]';
  var exp = [ '[[[]]]', '[[[[]]]]', '[]' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 1';
  var src = '[[[[]]],[[[[]]]],[]]';
  var exp = [ [ '[[]]' ], [ '[[[]]]' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 2';
  var src = '[[[[]]],[[[[]]]],[]]';
  var exp = [ [ [ '[]' ] ], [ [ '[[]]' ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 3';
  var src = '[[[[]]],[[[[]]]],[]]';
  var exp = [ [ [ [] ] ], [ [ [ '[]' ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 4';
  var src = '[[[[]]],[[[[]]]],[]]';
  var exp = [ [ [ [] ] ], [ [ [ [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 5';
  var src = '[[[[]]],[[[[]]]],[]]';
  var exp = [ [ [ [] ] ], [ [ [ [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'empty array, extra unbalanced elements delimeters';
  var src = ' [   ] ';
  var exp = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 0';
  var src = '  [  [  [  []] ],[  [[  []  ]  ]],[   ]  ]  ';
  var exp = [ '[', '[', '[]]', ']', '[', '[[', '[]', ']', ']]', '[', ']' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 1';
  var src = '  [  [  [  []] ],[  [[  []  ]  ]],[   ]  ]  ';
  var exp = [ '[', [ '[]]' ], [ '[[', '[]' ], ']]', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 2';
  var src = '  [  [  [  []] ],[  [[  []  ]  ]],[   ]  ]  ';
  var exp = [ '[', [ [ ']' ] ], [ '[[', [] ], ']]', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 3';
  var src = '  [  [  [  []] ],[  [[  []  ]  ]],[   ]  ]  ';
  var exp = [ '[', [ [ ']' ] ], [ '[[', [] ], ']]', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 4';
  var src = '  [  [  [  []] ],[  [[  []  ]  ]],[   ]  ]  ';
  var exp = [ '[', [ [ ']' ] ], [ '[[', [] ], ']]', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 5';
  var src = '  [  [  [  []] ],[  [[  []  ]  ]],[   ]  ]  ';
  var exp = [ '[', [ [ ']' ] ], [ '[[', [] ], ']]', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'empty array';
  var src = '  [   ] ';
  var exp = [];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 0';
  var src = '  [  [  [  [  ] ] ],[  [ [  [  ]  ]  ] ],[   ]  ]  ';
  var exp = [ '[', '[', '[', ']', ']', ']', '[', '[', '[', '[', ']', ']', ']', ']', '[', ']' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 1';
  var src = '  [  [  [  [  ] ] ],[  [ [  [  ]  ]  ] ],[   ]  ]  ';
  var exp = [ [ '[', '[', ']', ']' ], [ '[', '[', '[', ']', ']', ']' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 2';
  var src = '  [  [  [  [  ] ] ],[  [ [  [  ]  ]  ] ],[   ]  ]  ';
  var exp = [ [ [ '[', ']' ] ], [ [ '[', '[', ']', ']' ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 3';
  var src = '  [  [  [  [  ] ] ],[  [ [  [  ]  ]  ] ],[   ]  ]  ';
  var exp = [ [ [ [] ] ], [ [ [ '[', ']' ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 4';
  var src = '  [  [  [  [  ] ] ],[  [ [  [  ]  ]  ] ],[   ]  ]  ';
  var exp = [ [ [ [] ] ], [ [ [ [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 5';
  var src = '  [  [  [  [  ] ] ],[  [ [  [  ]  ]  ] ],[   ]  ]  ';
  var exp = [ [ [ [] ] ], [ [ [ [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  test.close( 'arrays, balanced brackets' );

  /* - */

  test.open( 'arrays, unbalanced brackets' );

  test.case = 'array with nested arrays, without spaces, depth - 0';
  var src = '[[[[]]]]],[[[[[]]]],[[]]';
  var exp = [ '[[[]]]]]', '[[[[[]]]]', '[[]' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 1';
  var src = '[[[[]]]]],[[[[[]]]],[[]]';
  var exp = [ [ '[[]]]]' ], [ '[[[[]]]' ], [ '[' ] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 2';
  var src = '[[[[]]]]],[[[[[]]]],[[]]';
  var exp = [ [ [ '[]]]' ] ], [ [ '[[[]]' ] ], [ '[' ] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 3';
  var src = '[[[[]]]]],[[[[[]]]],[[]]';
  var exp = [ [ [ [ ']]' ] ] ], [ [ [ '[[]' ] ] ], [ '[' ] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 4';
  var src = '[[[[]]]]],[[[[[]]]],[[]]';
  var exp = [ [ [ [ ']]' ] ] ], [ [ [ [ '[' ] ] ] ], [ '[' ] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, without spaces, depth - 5';
  var src = '[[[[]]]]],[[[[[]]]],[[]]';
  var exp = [ [ [ [ ']]' ] ] ], [ [ [ [ '[' ] ] ] ], [ '[' ] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 0';
  var src = '  [[[[]]]  ]]  ,[  [  [[ []]]  ],  [  []]';
  var exp = [ '[[[]]]', ']]', '[', '[', '[[', '[]]]', ']', '[', '[]' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 1';
  var src = '  [[[[]]]  ]]  ,[  [  [[ []]]  ],  [  []]';
  var exp = [ [ '[[]]' ], ']]', '[', [ '[[', '[]]]' ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 2';
  var src = '  [[[[]]]  ]]  ,[  [  [[ []]]  ],  [  []]';
  var exp = [ [ [ '[]' ] ], ']]', '[', [ '[[', [ ']]' ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 3';
  var src = '  [[[[]]]  ]]  ,[  [  [[ []]]  ],  [  []]';
  var exp = [ [ [ [] ] ], ']]', '[', [ '[[', [ ']]' ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 4';
  var src = '  [[[[]]]  ]]  ,[  [  [[ []]]  ],  [  []]';
  var exp = [ [ [ [] ] ], ']]', '[', [ '[[', [ ']]' ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra unbalanced elements delimeters, depth - 5';
  var src = '  [[[[]]]  ]]  ,[  [  [[ []]]  ],  [  []]';
  var exp = [ [ [ [] ] ], ']]', '[', [ '[[', [ ']]' ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 0';
  var src = '  [ [ [ [  ] ] ]  ] ]  ,[  [  [ [ [  ] ] ]  ],  [  [  ] ]';
  var exp = [ '[', '[', '[', ']', ']', ']', ']', ']', '[', '[', '[', '[', '[', ']', ']', ']', ']', '[', '[', ']' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 1';
  var src = '  [ [ [ [  ] ] ]  ] ]  ,[  [  [ [ [  ] ] ]  ],  [  [  ] ]';
  var exp = [ [ '[', '[', ']', ']' ], ']', ']', '[', [ '[', '[', '[', ']', ']', ']' ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 2';
  var src = '  [ [ [ [  ] ] ]  ] ]  ,[  [  [ [ [  ] ] ]  ],  [  [  ] ]';
  var exp = [ [ [ '[', ']' ] ], ']', ']', '[', [ [ '[', '[', ']', ']' ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 3';
  var src = '  [ [ [ [  ] ] ]  ] ]  ,[  [  [ [ [  ] ] ]  ],  [  [  ] ]';
  var exp = [ [ [ [] ] ], ']', ']', '[', [ [ [ '[', ']' ] ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 4';
  var src = '  [ [ [ [  ] ] ]  ] ]  ,[  [  [ [ [  ] ] ]  ],  [  [  ] ]';
  var exp = [ [ [ [] ] ], ']', ']', '[', [ [ [ [] ] ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, extra balanced elements delimeters, depth - 5';
  var src = '  [ [ [ [  ] ] ]  ] ]  ,[  [  [ [ [  ] ] ]  ],  [  [  ] ]';
  var exp = [ [ [ [] ] ], ']', ']', '[', [ [ [ [] ] ] ], '[', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  test.close( 'arrays, unbalanced brackets' );
}

//

function strStructureParseOptionDepthForMaps( test )
{
  test.open( 'maps, without outside curly brackets' );

  test.case = 'map with nested map, depth - 0';
  var src = 'a:1 b:{} c:{d:e} f:{g:{h:i}}';
  var exp = { a : 1, b : '{}', c : '{d:e}', f : '{g:{h:i}}' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 1';
  var src = 'a:1 b:{} c:{d:e} f:{g:{h:i}}';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : { g : '{h:i}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 2';
  var src = 'a:1 b:{} c:{d:e} f:{g:{h:i}}';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : { g : { h : 'i' } } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 3';
  var src = 'a:1 b:{} c:{d:e} f:{g:{h:i}}';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : { g : { h : 'i' } } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  /* */

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 0';
  var src = '   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   ';
  var exp = { a : 1, b : '{}', c : '{d: e }', f : '{', g : '{', h : 'i : }}' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 1';
  var src = '   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   ';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : '{', g : '{', h : { i : '}}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 2';
  var src = '   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   ';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : '{', g : '{', h : { i : '}}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 3';
  var src = '   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   ';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : '{', g : '{', h : { i : '}}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  /* */

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 0';
  var src = '   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   ';
  var exp = { a : 1, b : '{  }', c : '{',  d : 'e }', f : '{', g : '{', h : 'i : } }' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 1';
  var src = '   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   ';
  var exp = { a : 1, b : {}, c : '{', d : 'e }', f : '{', g : '{', h : { i : '} }' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 2';
  var src = '   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   ';
  var exp = { a : 1, b : {}, c : '{', d : 'e }', f : '{', g : '{', h : { 'i' : '} }' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 3';
  var src = '   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   ';
  var exp = { a : 1, b : {}, c : '{', d : 'e }', f : '{', g : '{', h : { 'i' : '} }' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.close( 'maps, without outside curly brackets' );

  /* - */

  test.open( 'maps, outside curly brackets' );

  test.case = 'empty map';
  var src = '{}';
  var exp = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 0';
  var src = '{a:1 b:{} c:{d:e} f:{g:{h:i}}}';
  var exp = { a : 1, b : '{}', c : '{d:e}', f : '{g:{h:i}}' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 1';
  var src = '{a:1 b:{} c:{d:e} f:{g:{h:i}}}';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : { g : '{h:i}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 2';
  var src = '{a:1 b:{} c:{d:e} f:{g:{h:i}}}';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : { g : { h : 'i' } } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'map with nested map, depth - 3';
  var src = '{a:1 b:{} c:{d:e} f:{g:{h:i}}}';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : { g : { h : 'i' } } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  /* */

  test.case = 'empty map';
  var src = ' {   }';
  var exp = {};
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 0';
  var src = ' {   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   } ';
  var exp = { a : 1, b : '{}', c : '{d: e }', f : '{', g : '{', h : 'i : }}' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 1';
  var src = ' {   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   } ';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : '{', g : '{', h : { i : '}}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 2';
  var src = ' {   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   } ';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : '{', g : '{', h : { i : '}}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 3';
  var src = ' {   a:1    b  :   {} c  :  {d: e } f  :  {  g  :  { h : i : }}   } ';
  var exp = { a : 1, b : {}, c : { d : 'e' }, f : '{', g : '{', h : { i : '}}' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  /* */

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 0';
  var src = ' {   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   } ';
  var exp = { a : 1, b : '{  }', c : '{',  d : 'e }', f : '{', g : '{', h : 'i : } }' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 1';
  var src = ' {   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   } ';
  var exp = { a : 1, b : {}, c : '{', d : 'e }', f : '{', g : '{', h : { i : '} }' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 2';
  var src = ' {   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   } ';
  var exp = { a : 1, b : {}, c : '{', d : 'e }', f : '{', g : '{', h : { 'i' : '} }' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'map with nested map, extra entryDelimeters, extra keyValDelimeters, depth - 3';
  var src = ' {   a : 1    b  :   {  } c  :  { d : e } f  :  {  g  :  { h : i : } }   } ';
  var exp = { a : 1, b : {}, c : '{', d : 'e }', f : '{', g : '{', h : { 'i' : '} }' } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.close( 'maps, outside curly brackets' );
}

//

function strStructureParseOptionDepthForMixed( test )
{
  test.open( 'arrays' );

  test.case = 'array with nested maps, without spaces, depth - 0';
  var src = '[[{},[[{a:[{b:3}]}]],],[[[{b:{c:2}},[]]]],[]]';
  var exp = [ '[{}', '[[{a:[{b:3}]}]]', ']', '[[[{b:{c:2}}', '[]]]]', '[]' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, without spaces, depth - 1';
  var src = '[[{},[[{a:[{b:3}]}]],],[[[{b:{c:2}},[]]]],[]]';
  var exp = [ '[{}', [ '[{a:[{b:3}]}]' ], ']', { '[[[{b' : '{c:2}}' }, [ ']]]' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, without spaces, depth - 2';
  var src = '[[{},[[{a:[{b:3}]}]],],[[[{b:{c:2}},[]]]],[]]';
  var exp = [ '[{}', [ [ '{a:[{b:3}]}' ] ], ']', { '[[[{b' : { c : '2}' } }, [ ']]]' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, without spaces, depth - 3';
  var src = '[[{},[[{a:[{b:3}]}]],],[[[{b:{c:2}},[]]]],[]]';
  var exp = [ '[{}', [ [ { a : [ '{b:3}' ] } ] ], ']', { '[[[{b' : { c : '2}' } }, [ ']]]' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, without spaces, depth - 4';
  var src = '[[{},[[{a:[{b:3}]}]],],[[[{b:{c:2}},[]]]],[]]';
  var exp = [ '[{}', [ [ { a : [ { b : 3 } ] } ] ], ']', { '[[[{b' : { c : '2}' } }, [ ']]]' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, without spaces, depth - 5';
  var src = '[[{},[[{a:[{b:3}]}]],],[[[{b:{c:2}},[]]]],[]]';
  var exp = [ '[{}', [ [ { a : [ { b : 3 } ] } ] ], ']', { '[[[{b' : { c : '2}' } }, [ ']]]' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'array with nested maps, extra hard unbalanced elements delimeters, depth - 0';
  var src = ' [[ {   },[  [ {a:[{b:3} ]} ] ],],[[[ {b: {c  :2}  },[   ]]  ] ],[] ] ';
  var exp = [ '[', '{', '}', '[', '[', '{a:[{b:3}', ']}', ']', ']', ']', '[[[', '{b:', '{c', ':2}', '}', '[', ']]', ']', ']', '[]' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra hard unbalanced elements delimeters, depth - 1';
  var src = ' [[ {   },[  [ {a:[{b:3} ]} ] ],],[[[ {b: {c  :2}  },[   ]]  ] ],[] ] ';
  var exp = [ [ '{', '}', '[', '[', '{a:[{b:3}', ']}', ']', ']' ], '[[[', { '{b' : 0 }, '{c', { '' : '2}' }, '}', [ ']]' ], ']', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra hard unbalanced elements delimeters, depth - 2';
  var src = ' [[ {   },[  [ {a:[{b:3} ]} ] ],],[[[ {b: {c  :2}  },[   ]]  ] ],[] ] ';
  var exp = [ [ {}, [ '[', '{a:[{b:3}', ']}', ']' ] ], '[[[', { '{b' : 0 }, '{c', { '' : '2}' }, '}', [ ']]' ], ']', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra hard unbalanced elements delimeters, depth - 3';
  var src = ' [[ {   },[  [ {a:[{b:3} ]} ] ],],[[[ {b: {c  :2}  },[   ]]  ] ],[] ] ';
  var exp = [ [ {}, [ [ '{a:[{b:3}', ']}' ] ] ], '[[[', { '{b' : 0 }, '{c', { '' : '2}' }, '}', [ ']]' ], ']', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra hard unbalanced elements delimeters, depth - 4';
  var src = ' [[ {   },[  [ {a:[{b:3} ]} ] ],],[[[ {b: {c  :2}  },[   ]]  ] ],[] ] ';
  var exp = [ [ {}, [ [ {a : '[{b:3' }, ']}' ] ] ], '[[[', { '{b' : 0 }, '{c', { '' : '2}' }, '}', [ ']]' ], ']', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra hard unbalanced elements delimeters, depth - 5';
  var src = ' [[ {   },[  [ {a:[{b:3} ]} ] ],],[[[ {b: {c  :2}  },[   ]]  ] ],[] ] ';
  var exp = [ [ {}, [ [ {a : { '[{b' : 3 } }, ']}' ] ] ], '[[[', { '{b' : 0 }, '{c', { '' : '2}' }, '}', [ ']]' ], ']', [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 0';
  var src = ' [ [ {   }, [  [ { a : [ { b : 3 } ] } ] ] , ] , [ [ [ { b : { c  : 2 }  }, [   ] ]  ] ],[  ] ] ';
  var exp = [ '[', '{', '}', '[', '[', '{', 'a', ':', '[', '{', 'b', ':', 3, '}', ']', '}', ']', ']', ']', '[', '[', '[', '{', 'b', ':', '{', 'c', ':', 2, '}', '}', '[', ']', ']', ']', ']', '[', ']' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 1';
  var src = ' [ [ {   }, [  [ { a : [ { b : 3 } ] } ] ] , ] , [ [ [ { b : { c  : 2 }  }, [   ] ]  ] ],[  ] ] ';
  var exp = [ [ '{', '}', '[', '[', '{', 'a', ':', '[', '{', 'b', ':', 3, '}', ']', '}', ']', ']' ], [ '[', '[', '{', 'b', ':', '{', 'c', ':', 2, '}', '}', '[', ']', ']', ']' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 2';
  var src = ' [ [ {   }, [  [ { a : [ { b : 3 } ] } ] ] , ] , [ [ [ { b : { c  : 2 }  }, [   ] ]  ] ],[  ] ] ';
  var exp = [ [ {}, [ '[', '{', 'a', ':', '[', '{', 'b', ':', 3, '}', ']', '}', ']' ] ], [ [ '[', '{', 'b', ':', '{', 'c', ':', 2, '}', '}', '[', ']', ']' ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 3';
  var src = ' [ [ {   }, [  [ { a : [ { b : 3 } ] } ] ] , ] , [ [ [ { b : { c  : 2 }  }, [   ] ]  ] ],[  ] ] ';
  var exp = [ [ {}, [ [ '{', 'a', ':', '[', '{', 'b', ':', 3, '}', ']', '}' ] ] ], [ [ [ '{', 'b', ':', '{', 'c', ':', 2, '}', '}', '[', ']' ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 4';
  var src = ' [ [ {   }, [  [ { a : [ { b : 3 } ] } ] ] , ] , [ [ [ { b : { c  : 2 }  }, [   ] ]  ] ],[  ] ] ';
  var exp = [ [ {}, [ [ { a : '[ {', b : '3 } ]' } ] ] ], [ [ [ { b : '{', c  : '2 }' }, [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 5';
  var src = ' [ [ {   }, [  [ { a : [ { b : 3 } ] } ] ] , ] , [ [ [ { b : { c  : 2 }  }, [   ] ]  ] ],[  ] ] ';
  var exp = [ [ {}, [ [ { a : '[ {', b : '3 } ]' } ] ] ], [ [ [ { b : '{', c  : '2 }' }, [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  /* */

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 0';
  var src = ' [ [ {}, [ [ { a : [{b:3}] } ] ] ], [ [ [ { b : {c:2} }, [] ] ] ],[] ] ';
  var exp = [ '[', '{}', '[', '[', '{', 'a', ':', '[{b:3}]', '}', ']', ']', ']', '[', '[', '[', '{', 'b', ':', '{c:2}', '}', '[]', ']', ']', ']', '[]' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 1';
  var src = ' [ [ {}, [ [ { a : [{b:3}] } ] ] ], [ [ [ { b : {c:2} }, [] ] ] ],[] ] ';
  var exp = [ [ '{}', '[', '[', '{', 'a', ':', '[{b:3}]', '}', ']', ']' ], [ '[', '[', '{', 'b', ':', '{c:2}', '}', '[]', ']', ']' ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 2';
  var src = ' [ [ {}, [ [ { a : [{b:3}] } ] ] ], [ [ [ { b : {c:2} }, [] ] ] ],[] ] ';
  var exp = [ [ {}, [ '[', '{', 'a', ':', '[{b:3}]', '}', ']', ] ], [ [ '[', '{', 'b', ':', '{c:2}', '}', '[]', ']' ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 3';
  var src = ' [ [ {}, [ [ { a : [{b:3}] } ] ] ], [ [ [ { b : {c:2} }, [] ] ] ],[] ] ';
  var exp = [ [ {}, [ [ '{', 'a', ':', '[{b:3}]', '}', ] ] ], [ [ [ '{', 'b', ':', '{c:2}', '}', '[]' ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 4';
  var src = ' [ [ {}, [ [ { a : [{b:3}] } ] ] ], [ [ [ { b : {c:2} }, [] ] ] ],[] ] ';
  var exp = [ [ {}, [ [ { a : [ '{b:3}' ], } ] ] ], [ [ [ { b : '{c:2}' }, [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.case = 'array with nested maps, extra unbalanced elements delimeters, depth - 5';
  var src = ' [ [ {}, [ [ { a : [{b:3}] } ] ] ], [ [ [ { b : {c:2} }, [] ] ] ],[] ] ';
  var exp = [ [ {}, [ [ { a : [ { b : 3 } ] } ] ] ], [ [ [ { b : { c  : 2 } }, [] ] ] ], [] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 5 } );
  test.identical( got, exp );

  test.close( 'arrays' );

  /* - */

  test.open( 'maps' );

  test.case = 'maps with nested arrays, without spaces, depth - 0';
  var src = '{a:[{b:{c:[{d:[e]}]}},[{f:{g:[h]}}]]}';
  var exp = { a : [ '{b:{c:[{d:[e]}]}}', '[{f:{g:[h]}}]' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, without spaces, depth - 1';
  var src = '{a:[{b:{c:[{d:[e]}]}},[{f:{g:[h]}}]]}';
  var exp = { a : [ { b : '{c:[{d:[e]}]}' }, [ '{f:{g:[h]}}' ] ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, without spaces, depth - 2';
  var src = '{a:[{b:{c:[{d:[e]}]}},[{f:{g:[h]}}]]}';
  var exp = { a : [ { b : { c : [ '{d:[e]}' ] } }, [ { f : '{g:[h]}' } ] ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, without spaces, depth - 3';
  var src = '{a:[{b:{c:[{d:[e]}]}},[{f:{g:[h]}}]]}';
  var exp = { a : [ { b : { c : [ { d : [ 'e' ] } ] } }, [ { f : { g : [ 'h' ] } } ] ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, without spaces, depth - 4';
  var src = '{a:[{b:{c:[{d:[e]}]}},[{f:{g:[h]}}]]}';
  var exp = { a : [ { b : { c : [ { d : [ 'e' ] } ] } }, [ { f : { g : [ 'h' ] } } ] ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  /* */

  test.case = 'maps with nested arrays, unbalanced elements delimeters, depth - 0';
  var src = '{a:[ {b:{ c:[{d:[e]}]}},[{ f:{g:[ h]}}]]}';
  var exp = { a : '[', '{b' : '{', c : '[{d:[e]}]}},[{', f : '{g:[ h]}}]]' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, unbalanced elements delimeters, depth - 1';
  var src = '{a:[ {b:{ c:[{d:[e]}]}},[{ f:{g:[ h]}}]]}';
  var exp = { a : '[', '{b' : '{', c : { '[{d' : '[e]}]}},[{' }, f : { '{g' : [ 'h]}}]' ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, unbalanced elements delimeters, depth - 2';
  var src = '{a:[ {b:{ c:[{d:[e]}]}},[{ f:{g:[ h]}}]]}';
  var exp = { a : '[', '{b' : '{', c : { '[{d' : '[e]}]}},[{' }, f : { '{g' : [ 'h]}}]' ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, unbalanced elements delimeters, depth - 3';
  var src = '{a:[ {b:{ c:[{d:[e]}]}},[{ f:{g:[ h]}}]]}';
  var exp = { a : '[', '{b' : '{', c : { '[{d' : '[e]}]}},[{' }, f : { '{g' : [ 'h]}}]' ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, unbalanced elements delimeters, depth - 4';
  var src = '{a:[ {b:{ c:[{d:[e]}]}},[{ f:{g:[ h]}}]]}';
  var exp = { a : '[', '{b' : '{', c : { '[{d' : '[e]}]}},[{' }, f : { '{g' : [ 'h]}}]' ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  /* */

  test.case = 'maps with nested arrays, full split, unbalanced elements delimeters, depth - 0';
  var src = '{ a : [ { b : { c : [ { d : [ e ] } ] } } , [ { f : { g : [ h ] } } ] ] }';
  var exp = { a : '[ {', 'b' : '{', c : '[ {', 'd' : '[ e ] } ] } } , [ {', f : '{', g : [ 'h', ']', '}', '}', ']' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, full split, unbalanced elements delimeters, depth - 1';
  var src = '{ a : [ { b : { c : [ { d : [ e ] } ] } } , [ { f : { g : [ h ] } } ] ] }';
  var exp = { a : '[ {', 'b' : '{', c : '[ {', 'd' : '[ e ] } ] } } , [ {', f : '{', g : [ 'h', ']', '}', '}', ']' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  /* */

  test.case = 'maps with nested arrays, unbalanced elements delimeters, depth - 0';
  var src = '{ a : [{b:{c:[{d:[e]}]}},[{f:{g:[h]}}]] }';
  var exp = { a : [ '{b:{c:[{d:[e]}]}}', '[{f:{g:[h]}}]' ] };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 0 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, balanced elements delimeters, depth - 1';
  var src = '{ a : [ {b:{c:[{d:[e]}]}},[{f:{g:[h]}}] ] }';
  var exp = { a : '[', '{b' : { '{c' : [ '{d:[e]}]}}', '[{f:{g:[h]}}]' ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, balanced elements delimeters, depth - 2';
  var src = '{ a : [ {b:{c:[{d:[e]}]}},[{f:{g:[h]}}] ] }';
  var exp = { a : '[', '{b' : { '{c' : [ { 'd' : '[e]}]}' }, [ '{f:{g:[h]}}' ] ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 2 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, balanced elements delimeters, depth - 3';
  var src = '{ a : [ {b:{c:[{d:[e]}]}},[{f:{g:[h]}}] ] }';
  var exp = { a : '[', '{b' : { '{c' : [ { 'd' : '[e]}]}' }, [ { 'f' : '{g:[h]}' } ] ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 3 } );
  test.identical( got, exp );

  test.case = 'maps with nested arrays, balanced elements delimeters, depth - 4';
  var src = '{ a : [ {b:{c:[{d:[e]}]}},[{f:{g:[h]}}] ] }';
  var exp = { a : '[', '{b' : { '{c' : [ { 'd' : '[e]}]}' }, [ { f : { g : [ 'h' ] } } ] ] } };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4 } );
  test.identical( got, exp );

  test.close( 'maps' );
}

//

function strStructureParseOptionOnTerminal( test )
{
  var onTerminal = function( e )
  {
    if( !_.strIs( e ) )
    return e;

    if( e === 'null' )
    return null;
    if( e === 'undefined' )
    return undefined;
    if( e === 'NaN' )
    return NaN;
    if( e === 'Infinity' )
    return Infinity;
    if( e === '-Infinity' )
    return -Infinity;
    if( e === 'false' )
    return false;
    if( e === 'true' )
    return true;

    return e;
  }

  /* */

  test.case = 'array with all primitives';
  var src = '[ abc, 2, 2.1, NaN, Infinity, -Infinity, null, undefined, false, true ]';
  var exp = [ 'abc', 2, 2.1, NaN, Infinity, -Infinity, null, undefined, false, true ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, onTerminal : onTerminal } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, all primitives, duplicates, depth - 1';
  var src = '[ abc, [ 2, 2.1, NaN, Infinity ], [ [ -Infinity, null ], undefined ], false, true, abc, [ 2, 2.1, NaN, Infinity ], [ [ -Infinity, null ], undefined ], false, true ]';
  var exp = [ 'abc', [ 2, 2.1, NaN, Infinity ], [ '[', -Infinity, null, ']', undefined ], false, true, 'abc', [ 2, 2.1, NaN, Infinity ], [ '[', -Infinity, null, ']', undefined ], false, true ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1, onTerminal : onTerminal } );
  test.identical( got, exp );

  test.case = 'array with nested arrays, all primitives, duplicates, depth - 4';
  var src = '[ abc, [ 2, 2.1, NaN, Infinity ], [ [ -Infinity, null ], undefined ], false, true, abc, [ 2, 2.1, NaN, Infinity ], [ [ -Infinity, null ], undefined ], false, true ]';
  var exp = [ 'abc', [ 2, 2.1, NaN, Infinity ], [ [ -Infinity, null ], undefined ], false, true, 'abc', [ 2, 2.1, NaN, Infinity ], [ [ -Infinity, null ], undefined ], false, true ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4, onTerminal : onTerminal } );
  test.identical( got, exp );

  test.case = 'array with nested maps, all primitives, duplicates, depth - 1';
  var src = '[ abc, [ { 2 : 2.1 }, NaN, Infinity ], [ [ -Infinity, { null : null } ], undefined ], false, true, abc, [ { 2 : 2.1 }, NaN, Infinity ], [ [ -Infinity, { null : null } ], undefined ], false, true ]';
  var exp = [ 'abc', [ '{', 2, ':', 2.1, '}', NaN, Infinity ], [ '[', -Infinity, '{', null, ':', null, '}', ']', undefined ], false, true, 'abc', [ '{', 2, ':', 2.1, '}', NaN, Infinity ], [ '[', -Infinity, '{', null, ':', null, '}', ']', undefined ], false, true ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 1, onTerminal : onTerminal } );
  test.identical( got, exp );

  test.case = 'array with nested maps, all primitives, duplicates, depth - 4';
  var src = '[ abc, [ { 2 : 2.1 }, NaN, Infinity ], [ [ -Infinity, { null : null } ], undefined ], false, true, abc, [ { 2 : 2.1 }, NaN, Infinity ], [ [ -Infinity, { null : null } ], undefined ], false, true ]';
  var exp = [ 'abc', [ { 2 : 2.1 }, NaN, Infinity ], [ [ -Infinity, { null : null } ], undefined ], false, true, 'abc', [ { 2 : 2.1 }, NaN, Infinity ], [ [ -Infinity, { null : null } ], undefined ], false, true ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1, depth : 4, onTerminal : onTerminal } );
  test.identical( got, exp );

  /* */

  test.case = 'map with primitives';
  var src = '{ str : str 2 : 2 2.1 : 2.1 NaN : NaN Infinity : Infinity -Infinity : -Infinity null : null undefined : undefined }';
  var exp = { 'str' : 'str', 2 : 2, 2.1 : 2.1, NaN : NaN, Infinity : Infinity, '-Infinity' : -Infinity, null : null, undefined : undefined };
  var got = _.strStructureParse( { src : src, onTerminal : onTerminal } );
  test.identical( got, exp );

  test.case = 'map with nested arrays, entryDelimeter - comma, all primitives, depth - 1';
  var src = '{ str : [ str 2 2.1 ], NaN : [ { Infinity : Infinity, -Infinity : -Infinity, null : null, undefined : undefined } ] }';
  var exp = { 'str' : [ 'str', 2, 2.1 ], NaN : { '[ { Infinity' : Infinity },'-Infinity' : -Infinity, null : null, undefined : 'undefined } ]' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',', depth : 1, onTerminal : onTerminal } );
  test.identical( got, exp );

  test.case = 'map with nested arrays, entryDelimeter - comma, all primitives, depth - 4';
  var src = '{ str : [ str 2 2.1 ], NaN : [ { Infinity : Infinity, -Infinity : -Infinity, null : null, undefined : undefined } ] }';
  var exp = { 'str' : [ 'str', 2, 2.1 ], NaN : { '[ { Infinity' : Infinity },'-Infinity' : -Infinity, null : null, undefined : 'undefined } ]' };
  var got = _.strStructureParse( { src : src, parsingArrays : 1, entryDelimeter : ',', depth : 4, onTerminal : onTerminal } );
  test.identical( got, exp );
}

//

function strStructureParse( test )
{
  test.open( 'imply map' );

  test.case = 'src - empty string, default';
  var src = '';
  var expected = {};
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.case = 'src - empty string, options';
  var src = '';
  var expected = {};
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'src - empty string, defaultStructure - string';
  var src = '';
  var expected = '';
  var got = _.strStructureParse({ src : src, parsingArrays : 1, defaultStructure : 'string' });
  test.identical( got, expected );

  test.case = 'src - spaces';
  var src = '   ';
  var expected = {};
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'string without delimeters';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'src - string with pairs key-value';
  var src = 'number : 1 str : abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.case = 'several pairs, flat array in value';
  var src = 'number : 1 str : abc array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number : 1  str:abc array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'flat array, parsingArrays - 0';
  var src = ' [ 1  , abc ] ';
  var expected = '[ 1  , abc ]';
  var got = _.strStructureParse({ src : src, parsingArrays : 0 });
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left, quoting - 1';
  var src = { src : '"path:D":\\some\\path', keyValDelimeter : ':', quoting : 1 };
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right, quoting - 1';
  var src = { src : 'path:"D:\\some\\path"', keyValDelimeter : ':', quoting : 1 };
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted, quoting - 1';
  var src = { src : 'path:D:\\some\\path', keyValDelimeter : ':', quoting : 1 };
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strStructureParse( src );
  test.identical( got, expected );

  test.close( 'imply map' );

  /* */

  test.open( 'imply array' )

  test.case = 'empty array';
  var src = '[]';
  var expected = [];
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'array';
  var src = '[ 1, abc ]';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'array with extra spaces';
  var src = ' [ 1  , abc ] ';
  var expected = [ 1, 'abc' ];
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.case = 'array with spaces';
  var src = ' [ 1  ab cd ] ';
  var expected = [ 1, 'ab', 'cd' ];
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );

  test.close( 'imply array' )

  /* */

  test.open( 'keys with spaces' );

  test.case = 'single key with space';
  var src = 'a1 a1 : v1';
  var expected = { 'a1 a1' : 'v1' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'two keys with space';
  var src = 'a1 a1 : v1 b2 b2 : v2';
  var expected = { 'a1 a1' : 'v1 b2', 'b2' : 'v2' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'three keys with space';
  var src = 'a1 a1 : v1 b2 b2 : v2 c3 c3 : v3';
  var expected = { 'a1 a1' : 'v1 b2', 'b2' : 'v2 c3', 'c3' : 'v3' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'three keys, middle key with space';
  var src = 'a1 : v1 a2 a2 : v2 c3 : v3';
  var expected = { 'a1' : 'v1 a2', 'a2' : 'v2', 'c3' : 'v3' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.close( 'keys with spaces' );

  /* */

  test.open( 'vals with spaces' );

  test.case = 'single key, value with space';
  var src = 'a1 : v1 v2';
  var expected = { 'a1' : 'v1 v2' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'single key, value with space';
  var src = 'a1 : v1 v2 v3';
  var expected = { 'a1' : 'v1 v2 v3' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'two keys, value with space';
  var src = 'a1 : v1 v1 b2 : v2 v2';
  var expected = { 'a1' : 'v1 v1', 'b2' : 'v2 v2' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'two keys, value with space';
  var src = 'a1 : v1 v1 v1 b2 : v2 v2 v2';
  var expected = { 'a1' : 'v1 v1 v1', 'b2' : 'v2 v2 v2' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'three keys, value with space';
  var src = 'a1 : v1 v1 b2 : v2 v2 c3 : v3 v3';
  var expected = { 'a1' : 'v1 v1', 'b2' : 'v2 v2', 'c3' : 'v3 v3' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.close( 'vals with spaces' );

  /* */

  test.open( 'toNumberMaybe' );

  test.case = 'number like string as value';
  var src = 'a : 1a';
  var expected = { 'a' : '1a' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'number like string as value';
  var src = 'a : 1 a';
  var expected = { 'a' : '1 a' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'number like string as value';
  var src = 'a : 1 a b : 2 b';
  var expected = { 'a' : '1 a', 'b' : '2 b' };
  var got = _.strStructureParse({ src : src });
  test.identical( got, expected );

  test.case = 'number like string as value';
  var src = 'a : 1 a b : 2 b';
  var expected = { 'a' : '1 a', 'b' : '2 b' };
  var got = _.strStructureParse({ src : src, toNumberMaybe : 0 });
  test.identical( got, expected );

  test.close( 'toNumberMaybe' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strStructureParse() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a' }, 'extra' ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.strStructureParse( [ [ 'src', 'a' ] ] ) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', delimeter : ' ' } ) );

  test.case = 'keyValDelimeter is empty string';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', keyValDelimeter : '' } ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : [] } ) );

  test.case = 'wrong type of keyValDelimeter';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', keyValDelimeter : 1 } ) );

  test.case = 'wrong type of entryDelimeter';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', entryDelimeter : 1 } ) );

  test.case = 'defaultStructure is not "array", "map", "string"';
  test.shouldThrowErrorSync( () => _.strStructureParse( { src : 'a', defaultStructure : 'hashmap' } ) );
}

//

function strStructureParseExperiment( test )
{
  test.case = 'array, quoting || using preservingQuoting in array can improve results';
  var src = '[ "1", "abc", "abc" ]';
  var expected = [ '"1"', '"abc"', '"abc"' ];
  var expected2 = [ 1, 'abc', 'abc' ];
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'primitives, empty strings || more complex search for primitives';
  var src = '[ 1, abc, null, undefined, false, true, , "abc" ]';
  var expected = [ 1, 'abc', 'null', 'undefined', 'false', 'true', '"abc"' ];
  var expected2 = [ 1, 'abc', null, undefined, false, true, '', '"abc"' ]; // Dmytro : not sure with empty string it may be undefined
  var got = _.strStructureParse({ src : src, parsingArrays : 1 });
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'NaN || not sure it is need';
  var src = 'a : NaN';
  var expected = { 'a' : 'NaN' };
  var expected2 = { 'a' : NaN };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'BigInt || BigInt always skips';
  var src = 'a : 1n, b : 2n, c : 3n';
  var expected = { 'a' : 1, 'b' : 2, 'c' : 3 };
  var expected2 = { 'a' : 1n, 'b' : 2n, 'c' : 3n };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'BigInt';
  var src = '[ 1n, 2a, 3n, a2 ]';
  var expected = [ 1, 2, 3, 'a2' ];
  var expected2 = [ 1n, 2, 3n, 'a2' ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'values is a complex structure || maybe, option for complex structure search needs';
  var src = 'a : { a : 1, b : 2 }';
  var expected = { 'a' : '{', 'a' : 1, 'b' : 2 };
  var expected2 = { 'a' : { 'a' : 1, b : 2 } };
  var got = _.strStructureParse( { src : src } );
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'values is a complex structure || maybe level of recursion need';
  var src = '[ [ a, a ], [ b, b ], [ [], [] ] ]';
  var expected = [ '[', 'a', 'a', ']', '[', 'b', 'b', ']', '[', '[]', '[]', ']' ];
  var expected2 = [ [ 'a', 'a' ], [ 'b', 'b' ], [ [], [] ] ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );
  test.notIdentical( got, expected2 );

  test.case = 'values is a complex structure || maybe level of recursion need';
  var src = '[ { a : a } ]';
  var expected = [ '{', 'a', ':', 'a', '}' ];
  var expected2 = [ { 'a' : 'a' } ];
  var got = _.strStructureParse( { src : src, parsingArrays : 1 } );
  test.identical( got, expected );
  test.notIdentical( got, expected2 );
}
strStructureParseExperiment.experimental = 1;

//

function strWebQueryParseDefaultOptions( test )
{
  test.case = 'passed argument is string, does not affects by options';
  var src = 'complex+protocol://www.site.com:13/path/name?query=here&and=here#anchor';
  var expected = { 'complex+protocol' : '//www.site.com:13/path/name?query=here', 'and' : 'here#anchor' };
  var got = _.strWebQueryParse( src );
  test.identical( got, expected );

  /* */

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number:1&str=abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, values in square parentheses';
  var src = 'number : 1&str = abc&array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : '[1,abc]' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number = 1 & str:abc& array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : '[ 1  , abc ]' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path=D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path="D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path=D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path = D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1& b2 b2 = v2 v2& c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1', 'b2 b2' : 'v2 v2', 'c3 c3' : 'v3 v3' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1&b : 2a,&c = 3 a&d : 4abc&e = 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = '[]';
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1,& abc ]';
  var expected = '[ 1,& abc ]';
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  ,& abc ] ';
  var expected = '[ 1  ,& abc ]';
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  ab& cd ] ';
  var expected = '[ 1  ab& cd ]';
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1& str = abc]';
  var expected = { '[number' : 1, 'str' : 'abc]' };
  var got = _.strWebQueryParse( { src : src } );
  test.identical( got, expected );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strWebQueryParse() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : 'a' }, 'extra' ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( [ [ 'src', 'a' ] ] ) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : 'a', delimeter : ' ' } ) );

  test.case = 'keyValDelimeter is empty string';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : 'a', keyValDelimeter : '' } ) );

  test.case = 'wrong type of src';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : [] } ) );

  test.case = 'wrong type of keyValDelimeter';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : 'a', keyValDelimeter : 1 } ) );

  test.case = 'wrong type of entryDelimeter';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : 'a', entryDelimeter : 1 } ) );

  test.case = 'defaultStructure is not "array", "map", "string"';
  test.shouldThrowErrorSync( () => _.strWebQueryParse( { src : 'a', defaultStructure : 'hashmap' } ) );
}

//

function strWebQueryParseOptionEntryDelimeter( test )
{
  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some#string';
  var expected = 'some#string';
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number:1#str=abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, values in square parentheses';
  var src = 'number : 1#str = abc#array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : '[1,abc]' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number = 1 # str:abc# array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : '[ 1  , abc ]' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path="D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path:D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path : D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1# b2 b2 : v2 v2# c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1', 'b2 b2' : 'v2 v2', 'c3 c3' : 'v3 v3' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1#b : 2a,#c = 3 a#d : 4abc#e : 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = '[]';
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1,# abc ]';
  var expected = '[ 1,# abc ]';
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  ,# abc ] ';
  var expected = '[ 1  ,# abc ]';
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1 :ab# cd ] ';
  var expected = { '[ 1' : 'ab# cd ]' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : 1# str = abc]';
  var expected = { '[number' : 1, 'str' : 'abc]' };
  var got = _.strWebQueryParse( { src : src, entryDelimeter : '#' } );
  test.identical( got, expected );
}

//

function strWebQueryParseOptionKeyValDelimeter( test )
{
  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = 'some string';
  var expected = 'some string';
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number?1&str=abc';
  var expected = { number : 1, str : 'abc' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, values in square parentheses';
  var src = 'number ? 1&str = abc&array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : '[1,abc]' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number = 1 & str?abc& array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : '[ 1  , abc ]' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path?D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path="D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path?D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path ? D : \\some\\ path ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 v1& b2 b2 ? v2 v2& c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1', 'b2 b2' : 'v2 v2', 'c3 c3' : 'v3 v3' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1&b : 2a,&c = 3 a&d : 4abc&e ? 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '[]';
  var expected = '[]';
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ 1,& abc ]';
  var expected = '[ 1,& abc ]';
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  ,& abc ] ';
  var expected = '[ 1  ,& abc ]';
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1 ?ab& cd ] ';
  var expected = { '[ 1' : 'ab& cd ]' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number ? 1& str = abc]';
  var expected = { '[number' : 1, 'str' : 'abc]' };
  var got = _.strWebQueryParse( { src : src, keyValDelimeter : [ ':', '=', '?' ] } );
  test.identical( got, expected );
}

//

function strWebQueryParseOptionQuoting( test )
{
  test.open( 'quoting - 0' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = '"some string"';
  var expected = '"some string"';
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number:1&"str"=abc';
  var expected = { number : 1, '"str"' : 'abc' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, values in square parentheses';
  var src = 'number : 1&str = "abc"&array : [1,abc]';
  var expected = { number : 1, str : '"abc"', array : '[1,abc]' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number = 1 & str:"abc"& array :  [ 1  , abc ] ';
  var expected = { number : 1, str : '"abc"', array : '[ 1  , abc ]' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path=D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { '"path' : 'D":\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path="D:\\some\\path"';
  var expected = { path : '"D:\\some\\path"' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path=D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path = "D : \\some\\ path" ';
  var expected = { path : '"D : \\some\\ path"' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 "v1& b2" b2 = v2 v2& c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 "v1', 'b2" b2' : 'v2 v2', 'c3 c3' : 'v3 v3' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1&b : "2a,&c" = 3 a&d : 4abc&e = 5 abc';
  var expected = { 'a' : 1, 'b' : '"2a,', 'c"' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '"[]"';
  var expected = '"[]"';
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ "1,& abc" ]';
  var expected = '[ "1,& abc" ]';
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  ,& "abc" ] ';
  var expected = '[ 1  ,& "abc" ]';
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  "ab& cd" ] ';
  var expected = '[ 1  "ab& cd" ]';
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : "1& str" = abc]';
  var expected = { '[number' : '"1', 'str"' : 'abc]' };
  var got = _.strWebQueryParse( { src : src, quoting : 0 } );
  test.identical( got, expected );

  test.close( 'quoting - 0' );

  /* - */

  test.open( 'quoting - 1' );

  test.case = 'empty string';
  var src = '';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'spaces';
  var src = '   ';
  var expected = {};
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string without keyValDelimeter';
  var src = '"some string"';
  var expected = 'some string';
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string with keyValDelimeter, pairs key-value';
  var src = 'number:1&"str"=abc';
  var expected = { number : 1, 'str' : 'abc' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - string with keyValDelimeter, values in square parentheses';
  var src = 'number : 1&str = "abc"&array : [1,abc]';
  var expected = { number : 1, str : 'abc', array : '[1,abc]' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'several, flat array in value, with extra spaces';
  var src = ' number = 1 & str:"abc"& array :  [ 1  , abc ] ';
  var expected = { number : 1, str : 'abc', array : '[ 1  , abc ]' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, not quoted';
  var src = 'path=D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted left';
  var src = '"path:D":\\some\\path';
  var expected = { 'path:D' : '\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, quoted right';
  var src = 'path="D:\\some\\path"';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts';
  var src = 'path=D:\\some\\path';
  var expected = { path : 'D:\\some\\path' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'src - Windows path, two keyValDelimeters, three parts, extra spaces';
  var src = ' path = "D : \\some\\ path" ';
  var expected = { path : 'D : \\some\\ path' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string wiht one key-value pair, key and value has space';
  var src = 'a1 a1 : v1 v1';
  var expected = { 'a1 a1' : 'v1 v1' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string with three key-value pair, keys and values has space';
  var src = 'a1 a1 : v1 "v1& b2" b2 = v2 v2& c3 c3 : v3 v3';
  var expected = { 'a1 a1' : 'v1 v1', 'b2 b2' : 'v2 v2', 'c3 c3' : 'v3 v3' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string has number and combined number and strings value';
  var src = 'a : 1&b : "2a,&c" = 3 a&d : 4abc&e = 5 abc';
  var expected = { 'a' : 1, 'b' : '2a,', 'c' : '3 a', 'd' : '4abc', 'e' : '5 abc' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  /* */

  test.case = 'square parentheses, empty array';
  var src = '"[]"';
  var expected = '[]';
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses, array';
  var src = '[ "1,& abc" ]';
  var expected = '[ 1,& abc ]';
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'square parentheses array with extra spaces';
  var src = ' [ 1  ,& "abc" ] ';
  var expected = '[ 1  ,& abc ]';
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'array with spaces delimeters';
  var src = ' [ 1  "ab& cd" ] ';
  var expected = '[ 1  ab& cd ]';
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.case = 'string in square parentheses, with keyValDelimeter, pairs key-value';
  var src = '[number : "1& str" = abc]';
  var expected = { '[number' : 1, 'str' : 'abc]' };
  var got = _.strWebQueryParse( { src : src, quoting : 1 } );
  test.identical( got, expected );

  test.close( 'quoting - 1' );
}

//

function strWebQueryParse( test )
{

  /* */

  test.case = 'empty array';
  var src = ''
  var expected = {};
  var got = _.strWebQueryParse( src );
  test.identical( got, expected )

  test.case = 'trivial';
  var src = 'abc:3&def:gh&this=is'
  var expected = { 'abc' : 3, 'def' : 'gh', 'this' : 'is' };
  var got = _.strWebQueryParse( src );
  test.identical( got, expected )

  var exp = { running : 0 };
  var src = 'running:0';
  var got = _.strWebQueryParse( src );
  test.identical( got, exp );

  /* */

}

//

function strWebQueryStr( test )
{
  test.case = 'src - empty string';
  var src = '';
  var got = _.strWebQueryStr( src );
  test.identical( got, '' );

  test.case = 'src - string';
  var src = 'abc';
  var got = _.strWebQueryStr( src );
  test.identical( got, 'abc' );

  test.case = 'src - primitive';
  var src = 1;
  var got = _.strWebQueryStr( { src : src } );
  test.identical( got, '' );

  /* - */

  test.open( 'default options' );

  test.case = 'src - empty map';
  var src = {};
  var got = _.strWebQueryStr( { src : src } );
  test.identical( got, '' );

  test.case = 'src - map with empty string key';
  var src = { '' : 'empty', 'path' : '/', 'level' : 2 };
  var got = _.strWebQueryStr( { src : src } );
  test.identical( got, ':empty&path:/&level:2' );

  test.case = 'src - map with primitives in values';
  var src = { number : 1, null : null, undefined : undefined, str : 'str', empty : '', '' : 'empty', false : false };
  var got = _.strWebQueryStr( { src : src } );
  test.identical( got, 'number:1&null:null&undefined:undefined&str:str&empty:&:empty&false:false' );

  test.case = 'src - map with strings, keys and values has spaces';
  var src = { 'one space' : 'in value', 'two spaces in' : 'key and value' };
  var got = _.strWebQueryStr( { src : src } );
  test.identical( got, 'one space:in value&two spaces in:key and value' );

  test.close( 'default options' );

  /* - */

  test.open( 'keyValDelimeter - "#"' );

  test.case = 'src - empty map';
  var src = {};
  var got = _.strWebQueryStr( { src : src, keyValDelimeter : '#' } );
  test.identical( got, '' );

  test.case = 'src - map with empty string key';
  var src = { '' : 'empty', 'path' : '/', 'level' : 2 };
  var got = _.strWebQueryStr( { src : src, keyValDelimeter : '#' } );
  test.identical( got, '#empty&path#/&level#2' );

  test.case = 'src - map with primitives in values';
  var src = { number : 1, null : null, undefined : undefined, str : 'str', empty : '', '' : 'empty', false : false };
  var got = _.strWebQueryStr( { src : src, keyValDelimeter : '#' } );
  test.identical( got, 'number#1&null#null&undefined#undefined&str#str&empty#&#empty&false#false' );

  test.case = 'src - map with strings, keys and values has spaces';
  var src = { 'one space' : 'in value', 'two spaces in' : 'key and value' };
  var got = _.strWebQueryStr( { src : src, keyValDelimeter : '#' } );
  test.identical( got, 'one space#in value&two spaces in#key and value' );

  test.close( 'keyValDelimeter - "#"' );

  /* - */

  test.open( 'entryDelimeter - "?"' );

  test.case = 'src - empty map';
  var src = {};
  var got = _.strWebQueryStr( { src : src, entryDelimeter : '?' } );
  test.identical( got, '' );

  test.case = 'src - map with empty string key';
  var src = { '' : 'empty', 'path' : '/', 'level' : 2 };
  var got = _.strWebQueryStr( { src : src, entryDelimeter : '?' } );
  test.identical( got, ':empty?path:/?level:2' );

  test.case = 'src - map with primitives in values';
  var src = { number : 1, null : null, undefined : undefined, str : 'str', empty : '', '' : 'empty', false : false };
  var got = _.strWebQueryStr( { src : src, entryDelimeter : '?' } );
  test.identical( got, 'number:1?null:null?undefined:undefined?str:str?empty:?:empty?false:false' );

  test.case = 'src - map with strings, keys and values has spaces';
  var src = { 'one space' : 'in value', 'two spaces in' : 'key and value' };
  var got = _.strWebQueryStr( { src : src, entryDelimeter : '?' } );
  test.identical( got, 'one space:in value?two spaces in:key and value' );

  test.close( 'entryDelimeter - "?"' );

  /* - */

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strWebQueryStr() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strWebQueryStr( 'a', 'extra' ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.strWebQueryStr( [] ) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.strWebQueryStr( { src : {}, delimeter : '' } ) );
}

//

function strRequestParse( test )
{

  let o =
  {
    commandsDelimeter : ';',
    quoting : 1,
    parsingArrays : 1
  }

  test.case = 'only options';
  var src = 'number : 1 str : abc array : [1,abc]'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  test.identical( got.map, expectedMap );

  test.case = 'only commands';
  var src = '.command1 ; .command2'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = {};
  test.identical( got.map, expectedMap )
  test.identical( got.maps, [ {}, {} ] )
  test.identical( got.subject, '.command1' )
  test.identical( got.subjects, [ '.command1', '.command2' ] )

  test.case = 'command and option';
  var src = '.set v : 10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { v : 10 };
  var expectedSubject = '.set';
  test.identical( got.subject, expectedSubject );
  test.identical( got.map, expectedMap );

  test.case = 'two command and option';
  var src = '.build abc debug:0 ; .set v : 10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { debug : 0 };
  var expectedSubject = '.build abc';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.build abc', '.set' ] )
  test.identical( got.maps, [ { debug : 0 }, { v : 10 } ] )

  test.case = 'two command and option, quoted with "';
  var src = '".build abc debug:0 ; .set v : 10"'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { debug : 0 };
  var expectedSubject = '.build abc';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.build abc', '.set' ] )
  test.identical( got.maps, [ { debug : 0 }, { v : 10 } ] )

  test.case = 'quoted option value';
  var src = 'path:"some/path"'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { path : 'some/path' };
  test.identical( got.map, expectedMap )

  test.case = 'quoted windows path as value';
  var src = 'path:"D:\\some\\path"'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { path : 'D:\\some\\path' };
  test.identical( got.map, expectedMap )

  test.case = 'unqouted windows path as value';
  var src = 'path:D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { path : 'D:\\some\\path' };
  test.identical( got.map, expectedMap );

  test.case = 'unqouted windows path as value';
  var src = 'path : D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { path : 'D:\\some\\path' };
  test.identical( got.map, expectedMap )

  test.case = 'unqouted windows path as subject';
  var src = 'D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  // var expectedMap = {};
  // var expectedSubject = 'D:\\some\\path';
  test.identical( got.subject, '' );
  test.identical( got.map, { 'D' : '\\some\\path' } );
  test.identical( got.subjects, [ '' ] );
  test.identical( got.maps, [ { 'D' : '\\some\\path' } ] );
  // test.identical( got.subjects, [ 'D:\\some\\path' ] );
  // test.identical( got.maps, [ {} ] );

  test.case = '.run v:10 ';
  var src = '.run v:10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  var expectedMap = { v : 10 };
  var expectedSubject = '.run';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.run' ] )
  test.identical( got.maps, [ { v : 10 } ] )
  /* qqq : Vova? */

  test.case = 'command and unqouted windows path';
  var src = '.run D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  // var expectedMap = {};
  // var expectedSubject = '.run D:\\some\\path';
  // test.identical( got.subject, expectedSubject )
  // test.identical( got.map, expectedMap )
  // test.identical( got.subjects, [ '.run D:\\some\\path' ] )
  // test.identical( got.maps, [ {} ] )
  test.identical( got.subject, '.run' )
  test.identical( got.map, { 'D' : '\\some\\path' } )
  test.identical( got.subjects, [ '.run' ] )
  test.identical( got.maps, [ { 'D' : '\\some\\path' } ] )

  test.case = 'command and unqouted windows path with option';
  var src = '.run D:\\some\\path v:10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  // var expectedMap = { v : 10 };
  // var expectedSubject = '.run D:\\some\\path';
  test.identical( got.subject, '.run' )
  test.identical( got.map, { v : 10, 'D' : '\\some\\path' } )
  test.identical( got.subjects, [ '.run' ] )
  test.identical( got.maps, [ { v:10, 'D' : '\\some\\path' } ] )

  test.case = 'two complex commands, second with windows path as subject';
  var src = '.imply v :10 ; .run D:\\some\\path n : 2'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  test.identical( got.subject, '.imply' )
  test.identical( got.map, { v : 10 } )
  test.identical( got.subjects, [ '.imply', '.run' ] )
  test.identical( got.maps, [ { v:10 }, { n : 2, 'D' : '\\some\\path' } ] )

  test.case = 'subject in quotes';
  var src = '/some/app "v:7 beeping:0"'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strRequestParse( o2 );
  test.identical( got.subject, '/some/app "v:7 beeping:0"' )
  test.identical( got.map, {} )
  test.identical( got.subjects, [ '/some/app "v:7 beeping:0"' ] )
  test.identical( got.maps, [ {} ] )

}

//

function strRequestParseDefaultOptions( test )
{
  test.case = 'src - empty string';
  var src = '';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [] );

  test.case = 'src - string, simple command';
  var src = 'node';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node' );
  test.identical( got.subjects, [ 'node' ] );

  test.case = 'src - string, command with args';
  var src = 'node proto/dwtools/SomeTest.test.s';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node proto/dwtools/SomeTest.test.s' );
  test.identical( got.subjects, [ 'node proto/dwtools/SomeTest.test.s' ] );

  test.case = 'src - string, few command with delimeter';
  var src = 'rm -rf node_modules ; npm i';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {}, {} ] );
  test.identical( got.subject, 'rm -rf node_modules' );
  test.identical( got.subjects, [ 'rm -rf node_modules', 'npm i' ] );

  test.case = 'src - string, one options, value - number';
  var src = 'v:1';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 1 } );
  test.identical( got.maps, [ { v : 1 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - negative number';
  var src = 'v:-1';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : -1 } );
  test.identical( got.maps, [ { v : -1 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - negative number with dot';
  var src = 'v:-.01';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : -0.01 } );
  test.identical( got.maps, [ { v : -0.01 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - string';
  var src = 'r:someRoutine';
  var got = _.strRequestParse( src );
  test.identical( got.map, { r : 'someRoutine' } );
  test.identical( got.maps, [ { r : 'someRoutine' } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - empty array';
  var src = 'r:[]';
  var got = _.strRequestParse( src );
  test.identical( got.map, { r : [] } );
  test.identical( got.maps, [ { r : [] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - array with number and string';
  var src = 'r:[1,str]';
  var got = _.strRequestParse( src );
  test.identical( got.map, { r : [ 1, 'str' ] } );
  test.identical( got.maps, [ { r : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three options, value - string';
  var src = 'one:1 two:someRoutine three:[1,str]';
  var got = _.strRequestParse( src );
  test.identical( got.map, { one : 1, two : 'someRoutine', three : [ 1, 'str' ] } );
  test.identical( got.maps, [ { one : 1, two : 'someRoutine', three : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  /* */

  test.case = 'src - string, three options, same keys';
  var src = 'one:1 one:someRoutine one:[1,str]';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : [ 1, 'someRoutine', 'str' ] } );
  test.identical( got.maps, [ { one : [ 1, 'someRoutine', 'str' ] }  ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three separated options, value - string';
  var src = 'one:1 ; two:someRoutine ; three:[1,str]';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1 } );
  test.identical( got.maps, [ { one : 1 }, { two : 'someRoutine'}, { three : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '', '', '' ] );

  test.case = 'src - string, three separated options, same keys';
  var src = 'one:1 ; one:someRoutine ; one:[1,str]';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1 } );
  test.identical( got.maps, [ { one : 1 }, { one : 'someRoutine'}, { one : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '', '', '' ] );

  test.case = 'src - string, command with options';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s v:5 r:some';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s' ] );

  test.case = 'src - string, command with options, same keys';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s withModule:wTools withModule:wPath';
  var got = _.strRequestParse( src );
  test.identical( got.map, { withModule : 'wPath' } );
  test.identical( got.maps, [ { withModule : 'wPath' } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s' ] );

  test.case = 'src - string, two command with options';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s v:5 r:some ; node ./test.js v : [ 10, str ]';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s', 'node ./test.js' ] );

  test.case = 'src - string, two command with options, same keys';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s withModule:wTools withModule:wPath ; node ./test.js v : [ 10, str ]';
  var got = _.strRequestParse( src );
  test.identical( got.map, { withModule : 'wPath' } );
  test.identical( got.maps, [ { withModule : 'wPath' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s', 'node ./test.js' ] );

}

//

function strRequestParseDefaultOptionsQuotedValues( test )
{
  test.case = 'src - string, simple command';
  var src = '"node"';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node' );
  test.identical( got.subjects, [ 'node' ] );

  test.case = 'src - string, command with args';
  var src = '"node proto/dwtools/SomeTest.test.s"';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node proto/dwtools/SomeTest.test.s' );
  test.identical( got.subjects, [ 'node proto/dwtools/SomeTest.test.s' ] );

  test.case = 'src - string, few command with delimeter';
  var src = 'rm -rf "node_modules" ; npm i';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {}, {} ] );
  test.identical( got.subject, 'rm -rf "node_modules"' );
  test.identical( got.subjects, [ 'rm -rf "node_modules"', 'npm i' ] );

  test.case = 'src - string, one options, value - number';
  var src = 'v:"1"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 1 } );
  test.identical( got.maps, [ { v : 1 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - negative number';
  var src = 'v:"-1"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : -1 } );
  test.identical( got.maps, [ { v : -1 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - negative number with dot';
  var src = 'v:"-.01"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : -0.01 } );
  test.identical( got.maps, [ { v : -0.01 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - string';
  var src = 'r:"someRoutine"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { r : 'someRoutine' } );
  test.identical( got.maps, [ { r : 'someRoutine' } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - empty array';
  var src = 'r:"[]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { r : [] } );
  test.identical( got.maps, [ { r : [] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - array with number and string';
  var src = 'r:"[1,str]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { r : [ 1, 'str' ] } );
  test.identical( got.maps, [ { r : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three options, value - string';
  var src = 'one:"1" two:"someRoutine" three:"[1,str]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { one : 1, two : 'someRoutine', three : [ 1, 'str' ] } );
  test.identical( got.maps, [ { one : 1, two : 'someRoutine', three : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three options, same keys';
  var src = 'one:"1" one:"someRoutine" one:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : [ 1, 'someRoutine', 'str' ] } );
  test.identical( got.maps, [ { one : [ 1, 'someRoutine', 'str' ] }  ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three separated options, value - string';
  var src = 'one:"1" ; two:"someRoutine" ; three:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1 } );
  test.identical( got.maps, [ { one : 1 }, { two : 'someRoutine'}, { three : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '', '', '' ] );

  test.case = 'src - string, three separated options, same keys';
  var src = 'one:"1" ; one:"someRoutine" ; one:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1 } );
  test.identical( got.maps, [ { one : 1 }, { one : 'someRoutine'}, { one : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '', '', '' ] );

  test.case = 'src - string, command with options';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s v:"5" r:"some"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s' ] );

  test.case = 'src - string, command with options, same keys';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s withModule:"wTools" withModule:wPath';
  var got = _.strRequestParse( src );
  test.identical( got.map, { withModule : 'wPath' } );
  test.identical( got.maps, [ { withModule : 'wPath' } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s' ] );

  test.case = 'src - string, two command with options';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s v:5 r:"some" ; node ./test.js v : "[ 10, str ]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s', 'node ./test.js' ] );

  test.case = 'src - string, two command with options, same keys';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s withModule:"wTools" withModule:"wPath" ; node ./test.js v : "[ 10, str ]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { withModule : 'wPath' } );
  test.identical( got.maps, [ { withModule : 'wPath' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s', 'node ./test.js' ] );
}

//

function strRequestParseDefaultOptionsWindowsPaths( test )
{
  test.open( 'unquoted windows path' );

  test.case = 'src - string, command with args';
  var src = 'node D:\\some\\path';
  var got = _.strRequestParse( src );
  test.identical( got.map, { D : '\\some\\path' } );
  test.identical( got.maps, [ { D : '\\some\\path' } ] );
  test.identical( got.subject, 'node' );
  test.identical( got.subjects, [ 'node' ] );

  test.case = 'src - string, few command with delimeter, relative windows path';
  var src = 'rm -rf .\\node_modules ; npm i';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {}, {} ] );
  test.identical( got.subject, 'rm -rf .\\node_modules' );
  test.identical( got.subjects, [ 'rm -rf .\\node_modules', 'npm i' ] );

  test.case = 'src - string, command with options';
  var src = 'tst .run D:\\some\\path v:"5" r:"some"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { D : '\\some\\path', v : 5, r : 'some' } );
  test.identical( got.maps, [ { D : '\\some\\path', v : 5, r : 'some' } ] );
  test.identical( got.subject, 'tst .run' );
  test.identical( got.subjects, [ 'tst .run' ] );

  test.case = 'src - string, command with options, same keys';
  var src = 'tst .run D:\\some\\path withModule:"wTools" withModule:wPath';
  var got = _.strRequestParse( src );
  test.identical( got.map, { D : '\\some\\path', withModule : 'wPath' } );
  test.identical( got.maps, [ { D : '\\some\\path', withModule : 'wPath' } ] );
  test.identical( got.subject, 'tst .run' );
  test.identical( got.subjects, [ 'tst .run' ] );

  test.case = 'src - string, two command with options';
  var src = 'tst .run D:\\some\\path v:5 r:"some" ; node .\\test.js v : "[ 10, str ]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { D : '\\some\\path', v : 5, r : 'some' } );
  test.identical( got.maps, [ { D : '\\some\\path', v : 5, r : 'some' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run' );
  test.identical( got.subjects, [ 'tst .run', 'node .\\test.js' ] );

  test.case = 'src - string, two command with options, same keys';
  var src = 'tst .run D:\\some\\path withModule:"wTools" withModule:wPath ; node .\\test.js v : "[ 10, str ]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { D : '\\some\\path', withModule : 'wPath' } );
  test.identical( got.maps, [ { D : '\\some\\path', withModule : 'wPath' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run' );
  test.identical( got.subjects, [ 'tst .run', 'node .\\test.js' ] );

  test.close( 'unquoted windows path' );

  /* */

  test.open( 'quoted windows path' );

  test.case = 'src - string, command with args';
  var src = 'node "D:\\some\\path"';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node "D:\\some\\path"' );
  test.identical( got.subjects, [ 'node "D:\\some\\path"' ] );

  test.case = 'src - string, few command with delimeter, relative windows path';
  var src = 'rm -rf ".\\node_modules" ; npm i';
  var got = _.strRequestParse( src );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {}, {} ] );
  test.identical( got.subject, 'rm -rf ".\\node_modules"' );
  test.identical( got.subjects, [ 'rm -rf ".\\node_modules"', 'npm i' ] );

  test.case = 'src - string, command with options';
  var src = 'tst .run "D:\\some\\path" v:"5" r:"some"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' } ] );
  test.identical( got.subject, 'tst .run "D:\\some\\path"' );
  test.identical( got.subjects, [ 'tst .run "D:\\some\\path"' ] );

  test.case = 'src - string, command with options, same keys';
  var src = 'tst .run "D:\\some\\path" withModule:"wTools" withModule:wPath';
  var got = _.strRequestParse( src );
  test.identical( got.map, { withModule : 'wPath' } );
  test.identical( got.maps, [ { withModule : 'wPath' } ] );
  test.identical( got.subject, 'tst .run "D:\\some\\path"' );
  test.identical( got.subjects, [ 'tst .run "D:\\some\\path"' ] );

  test.case = 'src - string, two command with options';
  var src = 'tst .run "D:\\some\\path" v:5 r:"some" ; node ".\\test.js" v : "[ 10, str ]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run "D:\\some\\path"' );
  test.identical( got.subjects, [ 'tst .run "D:\\some\\path"', 'node ".\\test.js"' ] );

  test.case = 'src - string, two command with options, same keys';
  var src = 'tst .run "D:\\some\\path" withModule:"wTools" withModule:wPath ; node ".\\test.js" v : "[ 10, str ]"';
  var got = _.strRequestParse( src );
  test.identical( got.map, { withModule : 'wPath' } );
  test.identical( got.maps, [ { withModule : 'wPath' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run "D:\\some\\path"' );
  test.identical( got.subjects, [ 'tst .run "D:\\some\\path"', 'node ".\\test.js"' ] );

  test.close( 'quoted windows path' );
}

//

function strRequestParseOptionSeveralValues( test )
{
  test.case = 'src - string, simple command';
  var src = '"node"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node' );
  test.identical( got.subjects, [ 'node' ] );

  test.case = 'src - string, command with args';
  var src = '"node proto/dwtools/SomeTest.test.s"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {} ] );
  test.identical( got.subject, 'node proto/dwtools/SomeTest.test.s' );
  test.identical( got.subjects, [ 'node proto/dwtools/SomeTest.test.s' ] );

  test.case = 'src - string, few command with delimeter';
  var src = 'rm -rf "node_modules" ; npm i';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, {} );
  test.identical( got.maps, [ {}, {} ] );
  test.identical( got.subject, 'rm -rf "node_modules"' );
  test.identical( got.subjects, [ 'rm -rf "node_modules"', 'npm i' ] );

  test.case = 'src - string, one options, value - number';
  var src = 'v:"1"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { v : 1 } );
  test.identical( got.maps, [ { v : 1 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - negative number';
  var src = 'v:"-1"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { v : -1 } );
  test.identical( got.maps, [ { v : -1 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - negative number with dot';
  var src = 'v:"-.01"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { v : -0.01 } );
  test.identical( got.maps, [ { v : -0.01 } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - string';
  var src = 'r:"someRoutine"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { r : 'someRoutine' } );
  test.identical( got.maps, [ { r : 'someRoutine' } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - empty array';
  var src = 'r:"[]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { r : [] } );
  test.identical( got.maps, [ { r : [] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, one options, value - array with number and string';
  var src = 'r:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { r : [ 1, 'str' ] } );
  test.identical( got.maps, [ { r : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three options, value - string';
  var src = 'one:"1" two:"someRoutine" three:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1, two : 'someRoutine', three : [ 1, 'str' ] } );
  test.identical( got.maps, [ { one : 1, two : 'someRoutine', three : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three options, same keys';
  var src = 'one:"1" one:"someRoutine" one:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : [ 1, 'someRoutine', 'str' ] } );
  test.identical( got.maps, [ { one : [ 1, 'someRoutine', 'str' ] }  ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '' ] );

  test.case = 'src - string, three separated options, value - string';
  var src = 'one:"1" ; two:"someRoutine" ; three:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1 } );
  test.identical( got.maps, [ { one : 1 }, { two : 'someRoutine'}, { three : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '', '', '' ] );

  test.case = 'src - string, three separated options, same keys';
  var src = 'one:"1" ; one:"someRoutine" ; one:"[1,str]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { one : 1 } );
  test.identical( got.maps, [ { one : 1 }, { one : 'someRoutine'}, { one : [ 1, 'str' ] } ] );
  test.identical( got.subject, '' );
  test.identical( got.subjects, [ '', '', '' ] );

  test.case = 'src - string, command with options';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s v:"5" r:"some"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s' ] );

  test.case = 'src - string, command with options, same keys';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s withModule:"wTools" withModule:wPath';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { withModule : [ 'wTools', 'wPath' ] } );
  test.identical( got.maps, [ { withModule : [ 'wTools', 'wPath' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s' ] );

  test.case = 'src - string, two command with options';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s v:5 r:"some" ; node ./test.js v : "[ 10, str ]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { v : 5, r : 'some' } );
  test.identical( got.maps, [ { v : 5, r : 'some' }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s', 'node ./test.js' ] );

  test.case = 'src - string, two command with options, same keys';
  var src = 'tst .run /proto/dwtools/someRoutine.test.s withModule:"wTools" withModule:wPath ; node ./test.js v : "[ 10, str ]"';
  var got = _.strRequestParse( { src : src, severalValues : 1 } );
  test.identical( got.map, { withModule : [ 'wTools', 'wPath' ] } );
  test.identical( got.maps, [ { withModule : [ 'wTools', 'wPath' ] }, { v : [ 10, 'str' ] } ] );
  test.identical( got.subject, 'tst .run /proto/dwtools/someRoutine.test.s' );
  test.identical( got.subjects, [ 'tst .run /proto/dwtools/someRoutine.test.s', 'node ./test.js' ] );
}

//

function strRequestParseExperiment( test )
{
  test.case = 'positive number in option';
  var got = _.strRequestParse( 'n:1 rapidity:9' );
  test.identical( got.subject, '' )
  test.identical( got.map, { 'n' : 1, 'rapidity' : 9 } )
  test.identical( got.subjects, [ '' ] )
  test.identical( got.maps, [ { 'n' : 1, 'rapidity' : 9 } ] );

  test.case = 'negative number in option';
  var got = _.strRequestParse( 'n:1 rapidity:-9' );
  test.identical( got.subject, '' )
  test.identical( got.map, { 'n' : 1, 'rapidity' : -9 } )
  test.identical( got.subjects, [ '' ] )
  test.identical( got.maps, [ { 'n' : 1, 'rapidity' : -9 } ] )
}

strRequestParseExperiment.experimental = 1;
strRequestParseExperiment.description =
`
  Routine did not parse negative numbers. The reason of it is missed part of regexp in
  routine numberFromStrMaybe.
`

//

function strRequestStr( test )
{
  test.case = 'only options';
  var str = 'number : 1 str : abc array : [1,abc]';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'number:1 str:abc array:[1,abc]';
  test.identical( got, expected );

  test.case = 'only options, two parts';
  var str = 'number : 1 str : abc ; array : [1,abc]';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'number:1 str:abc ; array:[1,abc]';
  test.identical( got, expected );

  test.case = 'only commands';
  var str = '.command1 ; .command2';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.command1 ; .command2';
  test.identical( got, expected );

  test.case = 'command and option';
  var str = '.set v : 10';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.set v:10';
  test.identical( got, expected );

  test.case = 'two command and option';
  var str = '.build abc debug:0 ; .set v : 10';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.build abc debug:0 ; .set v:10';
  test.identical( got, expected );

  test.case = 'two command and option, quoted with "';
  var str = '".build abc debug:0 ; .set v : 10"'
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.build abc debug:0 ; .set v:10';
  test.identical( got, expected );

  test.case = 'quoted option value, quoting - 0';
  var str = 'path:"some/path"';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 0, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'path:"some/path"';
  test.identical( got, expected );

  test.case = 'quoted windows path as value';
  var str = 'path:"D:\\some\\path"';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'path:D:\\some\\path';
  test.identical( got, expected );

  test.case = 'unqouted windows path as value';
  var str = 'path:D:\\some\\path';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'path:D:\\some\\path';
  test.identical( got, expected );

  test.case = 'unqouted windows path as value';
  var str = 'path : D:\\some\\path';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'path:D:\\some\\path';
  test.identical( got, expected );

  test.case = 'unqouted windows path as subject';
  var str = 'D:\\some\\path';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = 'D:\\some\\path';
  test.identical( got, expected );

  test.case = 'command and unqouted windows path';
  var str = '.run D:\\some\\path';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.run D:\\some\\path';
  test.identical( got, expected );

  test.case = 'command and unqouted windows path with option';
  var str = '.run D:\\some\\path v:10';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.run D:\\some\\path v:10';
  test.identical( got, expected );

  test.case = 'two complex commands, second with windows path as subject';
  var str = '.imply v :10 ; .run D:\\some\\path n : 2';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '.imply v:10 ; .run D:\\some\\path n:2';
  test.identical( got, expected );

  test.case = 'subject in quotes';
  var str = '/some/app "v:7 beeping:0"';
  var src = _.strRequestParse( { src : str, commandsDelimeter : ';', quoting : 1, parsingArrays : 1 } );
  delete src[ 'original' ];
  var got = _.strRequestStr( src );
  var expected = '/some/app "v:7 beeping:0"';
  test.identical( got, expected );
}

//

// function strCommandParseOld( test )
// {
//   let o =
//   {
//     quoting : 1,
//     parsingArrays : 1
//   }

//   test.case = 'only options';
//   var src = 'number : 1 str : abc array : [1,abc]'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
//   test.identical( got.map, expectedMap )

//   test.case = 'only commands';
//   var src = '.command1 ; .command2'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = {};
//   test.identical( got.map, expectedMap )
//   test.identical( got.maps, [ {}] )
//   test.identical( got.subject, '.command1 ; .command2' )
//   test.identical( got.subjects, [ '.command1 ; .command2' ] )

//   test.case = 'command and option';
//   var src = '.set v : 10'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { v : 10 };
//   var expectedSubject = '.set';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )

//   test.case = 'two command and option';
//   var src = '.build abc debug:0 ; .set v : 10'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { debug : 0, v : 10 };
//   var expectedSubject = '.build abc';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ '.build abc'] )
//   test.identical( got.maps, [ { debug : 0, v : 10 } ] )

//   test.case = 'quoted option value';
//   var src = 'path:"some/path"'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { path : 'some/path' };
//   test.identical( got.map, expectedMap )

//   test.case = 'quoted windows path as value';
//   var src = 'path:"D:\\some\\path"'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { path : 'D:\\some\\path' };
//   test.identical( got.map, expectedMap )

//   test.case = 'unqouted windows path as value';
//   var src = 'path:D:\\some\\path'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { path : 'D:\\some\\path' };
//   test.identical( got.map, expectedMap )

//   test.case = 'unqouted windows path as value';
//   var src = 'path : D:\\some\\path'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { path : 'D:\\some\\path' };
//   test.identical( got.map, expectedMap )

//   test.case = 'unqouted windows path as subject';
//   var src = 'D:\\some\\path'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = {};
//   var expectedSubject = 'D:\\some\\path';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ 'D:\\some\\path' ] )
//   test.identical( got.maps, [ {} ] )

//   test.case = '.run v:10 ';
//   var src = '.run v:10'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { v : 10 };
//   var expectedSubject = '.run';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ '.run' ] )
//   test.identical( got.maps, [ { v : 10 } ] )

//   test.case = 'command and unqouted windows path';
//   var src = '.run D:\\some\\path'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = {};
//   var expectedSubject = '.run D:\\some\\path';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ '.run D:\\some\\path' ] )
//   test.identical( got.maps, [ {} ] )

//   test.case = 'command and unqouted windows path with option';
//   var src = '.run D:\\some\\path v:10'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { v : 10 };
//   var expectedSubject = '.run D:\\some\\path';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ '.run D:\\some\\path' ] )
//   test.identical( got.maps, [ { v:10 } ] )

//   test.case = 'two complex commands, second with windows path as subject, option have number like string';
//   var src = '.imply v :10 ; .run D:\\some\\path n : 2'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { v:10, n : 2 };
//   var expectedSubject = '.imply';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ '.imply' ] )
//   test.identical( got.maps, [ { v:10, n : 2 } ] )

//   test.case = 'two complex commands, second with windows path as subject';
//   var src = '.with module:module ; .run D:\\some\\path n : 2'
//   var o2 = _.mapExtend( null, o, { src } );
//   var got = _.strCommandParse( o2 );
//   var expectedMap = { 'module' : 'module ; .run D:\\some\\path', n : 2 };
//   var expectedSubject = '.with';
//   test.identical( got.subject, expectedSubject )
//   test.identical( got.map, expectedMap )
//   test.identical( got.subjects, [ expectedSubject ] )
//   test.identical( got.maps, [ expectedMap ] )
// }

//

function strCommandParse( test )
{

  test.open( 'subject* options*' );

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject options?' });
  test.identical( got.map, { v : 5 } )
  test.identical( got.subject, 'C:\\tests' )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject? options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject? options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject options' });
  test.identical( got.map, { v : 5 } )
  test.identical( got.subject, 'C:\\tests' )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject?' });
  test.identical( got.map, { } )
  test.identical( got.subject, src )

  var src = 'C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject' });
  test.identical( got.map, { } )
  test.identical( got.subject, src )

  /*  */

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject? options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject? options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject' });
  test.identical( got.map, {} )
  test.identical( got.subject, '.run C:\\tests v:5' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject?' });
  test.identical( got.map, {} )
  test.identical( got.subject, '.run C:\\tests v:5' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'options' });
  test.identical( got.map, { '.run C' : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = '.run C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'options?' });
  test.identical( got.map, { '.run C' : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  /*  */

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject? options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject? options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject' });
  test.identical( got.map, {} )
  test.identical( got.subject, '.run abc C:\\tests v:5' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'subject?' });
  test.identical( got.map, {} )
  test.identical( got.subject, '.run abc C:\\tests v:5' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'options' });
  test.identical( got.map, { '.run abc C' : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = '.run abc C:\\tests v:5 ';
  var got = _.strCommandParse({ src, commandFormat : 'options?' });
  test.identical( got.map, { '.run abc C' : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  test.close( 'subject* options*' );

  /*  */

  test.open( 'options* subject*' );

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options? subject' });
  test.identical( got.map, { v : 5 } )
  test.identical( got.subject, 'C:\\tests' )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options subject?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options? subject?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options subject' });
  test.identical( got.map, { v : 5 } )
  test.identical( got.subject, 'C:\\tests' )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'subject?' });
  test.identical( got.map, { } )
  test.identical( got.subject, src )

  var src = 'v:5 C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'subject' });
  test.identical( got.map, { } )
  test.identical( got.subject, src )

  /*  */

  var src = 'v:5 C:\\tests .run ';
  var got = _.strCommandParse({ src, commandFormat : 'options? subject' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = 'v:5 C:\\tests .run ';
  var got = _.strCommandParse({ src, commandFormat : 'options subject?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = 'v:5 C:\\tests .run ';
  var got = _.strCommandParse({ src, commandFormat : 'options? subject?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = 'v:5 C:\\tests .run ';
  var got = _.strCommandParse({ src, commandFormat : 'options subject' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = 'v:5 C:\\tests .run ';
  var got = _.strCommandParse({ src, commandFormat : 'subject' });
  test.identical( got.map, {} )
  test.identical( got.subject, 'v:5 C:\\tests .run' )

  var src = 'v:5 C:\\tests .run ';
  var got = _.strCommandParse({ src, commandFormat : 'subject?' });
  test.identical( got.map, {} )
  test.identical( got.subject, 'v:5 C:\\tests .run' )

  var src = 'v:5 C:\\tests .run';
  var got = _.strCommandParse({ src, commandFormat : 'options' });
  test.identical( got.map, { 'C' : '\\tests .run', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'v:5 C:\\tests .run';
  var got = _.strCommandParse({ src, commandFormat : 'options?' });
  test.identical( got.map, { 'C' : '\\tests .run', v : 5 } )
  test.identical( got.subject, '' )

  /*  */

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'options? subject' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'options subject?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat :  'options? subject?' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'options subject' });
  test.identical( got.map, { C : '\\tests', v : 5 } )
  test.identical( got.subject, '.run abc' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'subject' });
  test.identical( got.map, {} )
  test.identical( got.subject, 'v:5 C:\\tests .run abc' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'subject?' });
  test.identical( got.map, {} )
  test.identical( got.subject, 'v:5 C:\\tests .run abc' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'options' });
  test.identical( got.map, { 'C' : '\\tests .run abc', v : 5 } )
  test.identical( got.subject, '' )

  var src = 'v:5 C:\\tests .run abc';
  var got = _.strCommandParse({ src, commandFormat : 'options?' });
  test.identical( got.map, { 'C' : '\\tests .run abc', v : 5 } )
  test.identical( got.subject, '' )

  test.close( 'options* subject*' );

  /*  */

  var src = '.run C:\\tests v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject options' });
  test.identical( got.map, { 'C' : '\\tests', v : 5 } )
  test.identical( got.subject, '.run' )

  var src = 'v:5 .run C:\\tests';
  var got = _.strCommandParse({ src, commandFormat : 'options subject' });
  test.identical( got.map, { v : 5 } )
  test.identical( got.subject, '.run C:\\tests' )

  var src = 'C:\\tests .run v:5';
  var got = _.strCommandParse({ src, commandFormat : 'subject options' });
  test.identical( got.map, { '.run v' : 5 } )
  test.identical( got.subject, 'C:\\tests' )

  var src = '.run';
  var got = _.strCommandParse({ src, commandFormat : 'subject options?' });
  test.identical( got.map, {} )
  test.identical( got.subject, '.run' )

  if( !Config.debug )
  return;

  var src = '.run';
  test.shouldThrowErrorSync( () => _.strCommandParse({ src, commandFormat : 'subject options' }) );

  var src = '.run';
  test.shouldThrowErrorSync( () => _.strCommandParse({ src, commandFormat : 'options' }) );

  var src = '.run';
  test.shouldThrowErrorSync( () => _.strCommandParse({ src, commandFormat : 'subject? options' }) );
}

//

function strCommandsParse( test )
{
  let o =
  {
    commandsDelimeter : ';',
    quoting : 1,
    parsingArrays : 1
  }

  test.case = 'only options';
  var src = 'number : 1 str : abc array : [1,abc]'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { number : 1, str : 'abc', array : [ 1, 'abc' ] };
  test.identical( got.map, expectedMap )

  test.case = 'only commands';
  var src = '.command1 ; .command2'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = {};
  test.identical( got.map, expectedMap )
  test.identical( got.maps, [ {}, {} ] )
  test.identical( got.subject, '.command1' )
  test.identical( got.subjects, [ '.command1', '.command2' ] )

  test.case = 'command and option';
  var src = '.set v : 10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { v : 10 };
  var expectedSubject = '.set';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )

  test.case = 'two command and option';
  var src = '.build abc debug:0 ; .set v : 10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { debug : 0 };
  var expectedSubject = '.build abc';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.build abc', '.set' ] )
  test.identical( got.maps, [ { debug : 0 }, { v : 10 } ] )

  test.case = 'quoted option value';
  var src = 'path:"some/path"'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { path : 'some/path' };
  test.identical( got.map, expectedMap )

  test.case = 'quoted windows path as value';
  var src = 'path:"D:\\some\\path"'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { path : 'D:\\some\\path' };
  test.identical( got.map, expectedMap )

  test.case = 'unqouted windows path as value';
  var src = 'path:D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { path : 'D:\\some\\path' };
  test.identical( got.map, expectedMap )

  test.case = 'unqouted windows path as value';
  var src = 'path : D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { path : 'D:\\some\\path' };
  test.identical( got.map, expectedMap )

  test.case = 'unqouted windows path commandFormat:"subject options?"';
  var src = 'D:\\some\\path';
  var o2 = _.mapExtend( null, o, { src } );
  o2.commandFormat = 'subject options?';
  var got = _.strCommandsParse( o2 );
  test.identical( got.subject, 'D:\\some\\path' );
  test.identical( got.map, {} );
  test.identical( got.subjects, [ 'D:\\some\\path' ] );
  test.identical( got.maps, [ {} ] );

  test.case = 'unqouted windows path commandFormat:"subject? options"';
  var src = 'D:\\some\\path';
  var o2 = _.mapExtend( null, o, { src } );
  o2.commandFormat = 'subject? options';
  var got = _.strCommandsParse( o2 );
  test.identical( got.subject, '' );
  test.identical( got.map, { 'D' : '\\some\\path' } );
  test.identical( got.subjects, [ '' ] );
  test.identical( got.maps, [ { 'D' : '\\some\\path' } ] );

  test.case = 'unqouted windows path commandFormat:"subject? options?"';
  var src = 'D:\\some\\path';
  var o2 = _.mapExtend( null, o, { src } );
  o2.commandFormat = 'subject? options?';
  var got = _.strCommandsParse( o2 );
  test.identical( got.subject, '' );
  test.identical( got.map, { 'D' : '\\some\\path' } );
  test.identical( got.subjects, [ '' ] );
  test.identical( got.maps, [ { 'D' : '\\some\\path' } ] );

  test.case = '.run v:10 ';
  var src = '.run v:10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { v : 10 };
  var expectedSubject = '.run';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.run' ] )
  test.identical( got.maps, [ { v : 10 } ] )

  test.case = 'command and unqouted windows path';
  var src = '.run D:\\some\\path'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  /* qqq : Vova? */
  var expectedMap = { 'D' : '\\some\\path' };
  var expectedSubject = '.run';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.run' ] )
  test.identical( got.maps, [ { 'D' : '\\some\\path' } ] )

  test.case = 'command and unqouted windows path with option';
  var src = '.run D:\\some\\path v:10'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { v : 10, 'D' : '\\some\\path' };
  var expectedSubject = '.run';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.run' ] )
  test.identical( got.maps, [ { v:10, 'D' : '\\some\\path' } ] )

  test.case = 'two complex commands, second with windows path as subject';
  var src = '.imply v :10 ; .run D:\\some\\path n : 2'
  var o2 = _.mapExtend( null, o, { src } );
  var got = _.strCommandsParse( o2 );
  var expectedMap = { v : 10 };
  var expectedSubject = '.imply';
  test.identical( got.subject, expectedSubject )
  test.identical( got.map, expectedMap )
  test.identical( got.subjects, [ '.imply', '.run' ] )
  test.identical( got.maps, [ { v : 10 }, { n : 2, 'D' : '\\some\\path' } ] )

}

//

function strJoinMap( test )
{
  test.open( 'default options' );

  test.case = 'src - empty map';
  var src = {};
  var got = _.strJoinMap( { src : src } );
  test.identical( got, '' );

  test.case = 'src - map with empty string key';
  var src = { '' : 'empty', 'path' : '/', 'level' : 2 };
  var got = _.strJoinMap( { src : src } );
  test.identical( got, ':empty path:/ level:2' );

  test.case = 'src - map with primitives in values';
  var src = { number : 1, null : null, undefined : undefined, str : 'str', empty : '', '' : 'empty', false : false };
  var got = _.strJoinMap( { src : src } );
  test.identical( got, 'number:1 null:null undefined:undefined str:str empty: :empty false:false' );

  test.case = 'src - map with strings, keys and values has spaces';
  var src = { 'one space' : 'in value', 'two spaces in' : 'key and value' };
  var got = _.strJoinMap( { src : src } );
  test.identical( got, 'one space:in value two spaces in:key and value' );

  test.close( 'default options' );

  /* - */

  test.open( 'keyValDelimeter - "::"' );

  test.case = 'src - empty map';
  var src = {};
  var got = _.strJoinMap( { src : src, keyValDelimeter : '::' } );
  test.identical( got, '' );

  test.case = 'src - map with empty string key';
  var src = { '' : 'empty', 'path' : '/', 'level' : 2 };
  var got = _.strJoinMap( { src : src, keyValDelimeter : '::' } );
  test.identical( got, '::empty path::/ level::2' );

  test.case = 'src - map with primitives in values';
  var src = { number : 1, null : null, undefined : undefined, str : 'str', empty : '', '' : 'empty', false : false };
  var got = _.strJoinMap( { src : src, keyValDelimeter : '::' } );
  test.identical( got, 'number::1 null::null undefined::undefined str::str empty:: ::empty false::false' );

  test.case = 'src - map with strings, keys and values has spaces';
  var src = { 'one space' : 'in value', 'two spaces in' : 'key and value' };
  var got = _.strJoinMap( { src : src, keyValDelimeter : '::' } );
  test.identical( got, 'one space::in value two spaces in::key and value' );

  test.close( 'keyValDelimeter - "::"' );

  /* - */

  test.open( 'entryDelimeter - "|"' );

  test.case = 'src - empty map';
  var src = {};
  var got = _.strJoinMap( { src : src, entryDelimeter : '|' } );
  test.identical( got, '' );

  test.case = 'src - map with empty string key';
  var src = { '' : 'empty', 'path' : '/', 'level' : 2 };
  var got = _.strJoinMap( { src : src, entryDelimeter : '|' } );
  test.identical( got, ':empty|path:/|level:2' );

  test.case = 'src - map with primitives in values';
  var src = { number : 1, null : null, undefined : undefined, str : 'str', empty : '', '' : 'empty', false : false };
  var got = _.strJoinMap( { src : src, entryDelimeter : '|' } );
  test.identical( got, 'number:1|null:null|undefined:undefined|str:str|empty:|:empty|false:false' );

  test.case = 'src - map with strings, keys and values has spaces';
  var src = { 'one space' : 'in value', 'two spaces in' : 'key and value' };
  var got = _.strJoinMap( { src : src, entryDelimeter : '|' } );
  test.identical( got, 'one space:in value|two spaces in:key and value' );

  test.close( 'entryDelimeter - "|"' );

  if( !Config.debug )
  return;

  test.case = 'without arguments';
  test.shouldThrowErrorSync( () => _.strJoinMap() );

  test.case = 'extra arguments';
  test.shouldThrowErrorSync( () => _.strJoinMap( { src : { a : 'a' } }, ' ' ) );

  test.case = 'wrong type of options map';
  test.shouldThrowErrorSync( () => _.strJoinMap( 'wrong' ) );

  test.case = 'unknown option in options map';
  test.shouldThrowErrorSync( () => _.strJoinMap( { src : { a : 'a' }, delimeter : '' } ) );

  test.case = 'wrong type of keyValDelimeter';
  test.shouldThrowErrorSync( () => _.strJoinMap( { src : { a : 'a' }, keyValDelimeter : 1 } ) );

  test.case = 'wrong type of entryDelimeter';
  test.shouldThrowErrorSync( () => _.strJoinMap( { src : { a : 'a' }, entryDelimeter : 1 } ) );
}

//

function strDifference( test )
{

  test.case = 'returns the string';
  var got = _.strDifference( 'abc', 'abd' );
  var expected = 'ab*';
  test.identical( got, expected );

  test.case = 'returns the string where the difference in the first letter';
  var got = _.strDifference( 'abc', 'def' );
  var expected = '*';
  test.identical( got, expected );

  test.case = 'returns false because arguments are equal';
  var got = _.strDifference( 'abc', 'abc' );
  var expected = false;
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strDifference( );
  } );

  test.case = 'first argument is wrong';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strDifference( [  ], 'abc' );
  } );

  test.case = 'second argument is wrong';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strDifference( 'abc', 13 );
  } );

  test.case = 'not enough arguments';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strDifference( 'abc' );
  } );

}

//

function strLattersSpectre( test )
{

  test.case = 'returns the object';
  var got = _.strLattersSpectre( 'abcacc' );
  var expected = new U32x([ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 6 ]);
  test.identical( got, expected );

  /**/

  if( !Config.debug )
  return;

  test.case = 'no arguments';
  test.shouldThrowErrorOfAnyKind( function( )
  {
    _.strLattersSpectre( );
  } );

};

//

// function experiment()
// {
//   let times = 100;
//   let size = 500000;
//   let array = new U8x( size );
//
//   var counter = 0;
//   var time = _.time.now();
//   for( let i = times ; i > 0; i-- )
//   var result = forLoop( array, () => counter += 1 );
//   console.log( `For loop took ${_.time.spent( time )} on Njs ${process.version}` );
//   console.info( `Output ${counter} to avoid unwanted optimization` );
//
//   var counter = 0;
//   var time = _.time.now();
//   for( let i = times ; i > 0; i-- )
//   var result = forEach( array, () => counter += 1 );
//   console.log( `For each took ${_.time.spent( time )} on Njs ${process.version}` );
//   console.info( `Output ${counter} to avoid unwanted optimization` );
//
//   function forLoop( src, onEach )
//   {
//     for( let k = 0 ; k < src.length ; k++ )
//     onEach( src[ k ], k, src );
//     return src
//   }
//
//   function forEach( src, onEach )
//   {
//     src.forEach( ( e, k, src ) => onEach( e, k, src ) );
//     return src;
//   }
// }
//
// experiment.experimental = 1;

// --
//
// --

var Self =
{

  name : 'Tools.base.StringsExtra',
  silencing : 1,

  tests :
  {

    strCamelize,
    strToTitle,

    strFilenameFor,
    strHtmlEscape,

    //

    strSearchDefaultOptions,
    strSearchOptionNearestLines,
    strSearchOptionNearestSplitting,
    strSearchOptiondeterminingLineNumber,
    strSearchOptionStringWithRegexp,
    strSearchOptionToleratingSpaces,
    strSearchOptionOnTokenize,

    strSearchLog,
    strSearchReplace,

    strFindAll,
    strFindAllValueWithLong,

    tokensSyntaxFrom,

    strReplaceAllDefaultOptions,
    strReplaceAllOptionJoining,
    strReplaceAllOptionOnUnknown,
    strTokenizeJs,
    strSorterParse,

    //

    strMetricFormat,
    strMetricFormatBytes,
    strToBytes,
    strTimeFormat,

    strStructureParseDefaultOptions,
    strStructureParseOptionParsingArrays,
    strStructureParseOptionEntryDelimeter,
    strStructureParseOptionKeyValDelimeter,
    strStructureParseOptionQuoting,
    strStructureParseOptionToNumberMaybe,
    strStructureParseOptionDefaultStructure,
    strStructureParseOptionDepthForArrays,
    strStructureParseOptionDepthForMaps,
    strStructureParseOptionDepthForMixed,
    strStructureParseOptionOnTerminal,
    strStructureParse,
    strStructureParseExperiment,

    strWebQueryParseDefaultOptions,
    strWebQueryParseOptionEntryDelimeter,
    strWebQueryParseOptionKeyValDelimeter,
    strWebQueryParseOptionQuoting,
    strWebQueryParse,

    strWebQueryStr,
    strRequestParse,
    strRequestParseDefaultOptions,
    strRequestParseDefaultOptionsQuotedValues,
    strRequestParseDefaultOptionsWindowsPaths,
    strRequestParseOptionSeveralValues,
    strRequestParseExperiment,
    strRequestStr,
    strCommandParse,
    strCommandsParse,

    strJoinMap,

    //

    strDifference,
    strLattersSpectre,

  }

}

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
