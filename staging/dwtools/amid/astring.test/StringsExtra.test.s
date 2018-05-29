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

//

function strCapitalize( test )
{

  test.description = 'single word';
  var got = _.strCapitalize( 'one' );
  var expected = 'One';
  test.identical( got,expected );

  test.description = 'two words';
  var got = _.strCapitalize( 'one two' );
  var expected = 'One two';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments length';
    test.shouldThrowError( function()
    {
      _.strCapitalize( 'first','wrond argument' );
    });

    test.description = 'wrong type of argument';
    test.shouldThrowError( function()
    {
      _.strCapitalize( 777 );
    });

    test.description = 'no argument provided';
    test.shouldThrowError( function()
    {
      _.strCapitalize();
    });

  }
}

//

function strReplaceAll( test )
{
  test.description = 'simple replace';
  var got = _.strReplaceAll( 'aabaa','b','c' );
  var expected = 'aacaa';
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
  var got = _.strReplaceAll( { src : 'aaax', dictionary : { 'x' : 'a' } } );
  var expected = 'aaaa';
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

  //

  test.description = 'regexp';

  var got = _.strReplaceAll( 'aabaa',/b/gm,'c' );
  var expected = 'aacaa';
  test.identical( got,expected );

  debugger
  var got = _.strReplaceAll( '12345',/[1-3]/gm,'0' );
  var expected = '00045';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaabac',/a+/gm,'b' );
  var expected = 'bbbc';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaabaaacaaad',/a+[^bc]$/gm,'x' );
  var expected = 'aaabaaacx';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaaa',[ 'a' ], [ 'b' ] );
  var expected = 'bbbb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaaa',[ /a/ ], [ 'b' ] );
  var expected = 'baaa';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaaa',[ /a/gm ], [ 'b' ] );
  var expected = 'bbbb';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaaabbbb',[ 'a', 'b' ], [ 'c', 'd' ] );
  var expected = 'ccccdddd';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaaabbbb',[ /a/gm, /b/gm ], [ 'c', 'd' ] );
  var expected = 'ccccdddd';
  test.identical( got,expected );

  var got = _.strReplaceAll( 'aaaabbbb',[ /a/gm, 'b' ], [ 'c', 'd' ] );
  var expected = 'ccccdddd';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

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
      _.strReplaceAll( { dst : 'aaax', dictionary : { 'a' : [ 1, 2 ] } } )
    });

    test.shouldThrowError( function()
    {
      _.strReplaceAll( 'aaaabbbb',[ 'a' ], [ 'c', 'd' ] );
    });

    test.shouldThrowError( function()
    {
      _.strReplaceAll( 'aaaabbbb',[ 'a', 'b' ], [ 'x' ] );
    });

    test.shouldThrowError( function()
    {
      _.strReplaceAll( 'aaaabbbb',{ 'a' : [ 'x' ] } );
    });
  }
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

  if( Config.debug )
  {

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
}

//

function strIndentation( test )
{
  var got, expected;

  //

  test.description = 'single line';

  /**/

  got = _.strIndentation( '', '_' );
  expected = '_';
  test.identical( got, expected );

  /* no new lines, returns tab + source */

  got = _.strIndentation( 'abc', '_' );
  expected = '_abc';
  test.identical( got, expected );

  //

  test.description = 'multiline';

  /**/

  got = _.strIndentation( 'a\nb', '_' );
  expected = '_a\n_b';
  test.identical( got, expected );

  /* tab before first and each new line */

  got = _.strIndentation( '\na\nb\nc', '_' );
  expected = '_\n_a\n_b\n_c';
  test.identical( got, expected );

  /* tabs count = new lines count + 1 for first line */

  got = _.strIndentation( '\n\n\n', '_' );
  expected = '_\n_\n_\n_';
  test.identical( got, expected );

  /**/

  got = _.strIndentation( 'a\nb\nc','\t' );
  expected = '\ta\n\tb\n\tc';
  test.identical( got,expected );

  //

  test.description = 'array';

  /**/

  got = _.strIndentation( [ 'a', 'b', 'c' ],'_' );
  expected = '_a\n_b\n_c';
  test.identical( got,expected );

  /* join array to string */

  var arr = [ 'a\nb', 'b\nc', 'c\nd' ];
  got = _.strIndentation( arr.join( '\n' ), '_' );
  expected = '_a\n_b\n_b\n_c\n_c\n_d';
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strIndentation( 'one','two','three' );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strIndentation( );
    });

    test.description = 'first argument type is wrong';
    test.shouldThrowError( function()
    {
      _.strIndentation( 123,'second' );
    });

    test.description = 'second argument type is wrong';
    test.shouldThrowError( function()
    {
      _.strIndentation( 'first', 321 );
    });
  }
}

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

function toStrMethods( test )
{
  test.description = 'converts routine to string default options';
  var got = _.toStrMethods( function route() {} );
  var expected = '[ routine route ]';
  test.identical( got,expected );

  test.description = 'converts routine to string, levels:0';
  var got = _.toStrMethods( function route() {}, { levels : 0 } );
  var expected = '[ routine route ]';
  test.identical( got,expected );

  test.description = 'different input data types';
  var got = _.toStrMethods( [ function route() {}, 0, '1', null ] );
  var expected = '';
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {
    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.toStrMethods( 'one','two' );
    });

    test.description = 'wrong arguments count';
    test.shouldThrowError( function()
    {
      _.toStrMethods( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
    });

    test.description = 'onlyRoutines & noRoutine both true';
    test.shouldThrowError( function()
    {
      _.toStrMethods( function f () {},{ noRoutine : 1 } );
    });
  }
}

//

function toStrFields( test )
{
  test.description = 'Fields default options';
  var got = _.toStrFields( [ 1, 2, 'text', undefined ] );
  var expected = '[ 1, 2, "text", undefined ]';
  test.identical( got,expected );

  test.description = 'Fields, levels : 0';
  var got = _.toStrFields( [ 1, 2, 'text', undefined ], { levels : 0 } );
  var expected = '[ Array with 4 elements ]';
  test.identical( got,expected );

  test.description = 'Ignore routine';
  var got = _.toStrFields( [ function f () {}, 1, 2, 3 ] );
  var expected = '[ 1, 2, 3 ]';
  test.identical( got,expected );

  test.description = 'no arguments';
  var got = _.toStrFields();
  var expected = 'undefined';
  test.identical( got,expected );



  /**/

  if( Config.debug )
  {
    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.toStrFields( 'one','two' );
    });

    test.description = 'wrong arguments count';
    test.shouldThrowError( function()
    {
      _.toStrFields( { a : 1 }, { b : 1 }, { jsonLike : 1 } );
    });

    test.description = 'onlyRoutines & noRoutine both true';
    test.shouldThrowError( function()
    {
      _.toStrFields( function f () {}, { onlyRoutines : 1 } );
    });

  }
}

//

function _toStrShort( test )
{
  test.description = 'Array length test';
  var got = _._toStrShort( [ 1, 2, 'text', undefined ], { } );
  var expected = '[ Array with 4 elements ]';
  test.identical( got,expected );

  test.description = 'date to string';
  var got = _._toStrShort( new Date( Date.UTC( 1993, 12, 12 ) ), { }  );
  var expected = '1994-01-12T00:00:00.000Z';
  test.identical( got,expected );

  test.description = 'string length > 40';
  var got = _._toStrShort( 'toxtndmtmdbmmlzoirmfypyhnrrqfuvybuuvixyrx', { stringWrapper : '"' } );
  var expected = '[ "toxtndmtmdbmmlzoirmf" ... "pyhnrrqfuvybuuvixyrx" ]';
  test.identical( got,expected );

  test.description = 'string with options';
  var got = _._toStrShort( '\toxtndmtmdb', { escaping : 1 } );
  var expected = '\\toxtndmtmdb';
  test.identical( got,expected );

  test.description = 'error to string ';
  var got = _._toStrShort( new Error( 'err' ), { } );
  var expected = '[object Error]';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _._toStrShort( '1', 2 );
    });

    test.description = 'only one argument provided';
    test.shouldThrowError( function()
    {
      _._toStrShort( '1' );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrShort( );
    });

  }
}

//

function _toStrIsVisibleElement( test )
{
  test.description = 'default options';
  var got = _._toStrIsVisibleElement( 123, {} );
  var expected = true;
  test.identical( got,expected );

  test.description = 'noAtomic';
  var got = _._toStrIsVisibleElement( 'test', { noAtomic : 1 } );
  var expected = false;
  test.identical( got,expected );

  test.description = 'noObject';
  var got = _._toStrIsVisibleElement( { a : 'test' }, { noObject : 1 } );
  var expected = false;
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _._toStrIsVisibleElement( '1' );
    });

    // test.description = 'second argument is not a object';
    // test.shouldThrowError( function()
    // {
    //   _._toStrIsVisibleElement( '1', 2 );
    // });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrIsVisibleElement();
    });

  }
}

//

function _toStrIsSimpleElement( test )
{
  test.description = 'default options';
  var got = _._toStrIsSimpleElement( 123, {} );
  var expected = true;
  test.identical( got,expected );

  test.description = 'string length > 40';
  var got = _._toStrIsSimpleElement( 'toxtndmtmdbmmlzoirmfypyhnrrqfuvybuuvixyrx', {} );
  var expected = false;
  test.identical( got,expected );

  test.description = 'object test';
  var got = _._toStrIsSimpleElement( { a : 1 }, {} );
  var expected = false;
  test.identical( got,expected );

  test.description = 'atomic test';
  var got = _._toStrIsSimpleElement( undefined, {} );
  var expected = true;
  test.identical( got,expected );

  test.description = 'escaping test';
  var got = _._toStrIsSimpleElement( '\naaa', { escaping : 1 } );
  var expected = true;
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _._toStrIsSimpleElement( '1' );
    });

    test.description = 'second argument is not a object';
    test.shouldThrowError( function()
    {
      _._toStrIsSimpleElement( '1', 2 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrIsSimpleElement();
    });

  }
}

//

function _toStrFromRoutine( test )
{
  test.description = 'routine test';
  var got = _._toStrFromRoutine( function a () {} );
  var expected = '[ routine a ]';
  test.identical( got,expected );

  test.description = 'routine without name';
  var got = _._toStrFromRoutine( function() {} );
  var expected = '[ routine without name ]';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromRoutine( '1' );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrFromRoutine();
    });

  }
}

//

function _toStrFromNumber( test )
{
  test.description = 'default options';
  var got = _._toStrFromNumber( 123, {} );
  var expected = '123';
  test.identical( got,expected );

  test.description = 'number precision test';
  var got = _._toStrFromNumber( 123, { precision : 2 } );
  var expected = '1.2e+2';
  test.identical( got,expected );

  test.description = 'number fixed test';
  var got = _._toStrFromNumber( 123, { fixed : 2 } );
  var expected = '123.00';
  test.identical( got,expected );

  test.description = 'invalid option type';
  var got = _._toStrFromNumber( 123, { fixed : '2' } );
  var expected = '123';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromNumber( '1',{} );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromNumber( 1, 2 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrFromNumber();
    });

    test.description = 'precision out of range';
    test.shouldThrowError( function()
    {
      _._toStrFromNumber( 1, { precision : 22 });
    });

    test.description = 'fixed out of range';
    test.shouldThrowError( function()
    {
      _._toStrFromNumber( 1, { precision : 22 });
    });

  }
}

//

function _toStrFromStr( test )
{
  test.description = 'default options';
  var got = _._toStrFromStr( '123', {} );
  var expected = '123';
  test.identical( got,expected );

  test.description = 'escaping';
  var got = _._toStrFromStr( '\n123\u001b', { escaping : 1 } );
  var expected = '\\n123\\u001b';
  test.identical( got,expected );

  test.description = 'stringWrapper';
  var got = _._toStrFromStr( 'string', { stringWrapper : '"' } );
  var expected = '"string"';
  test.identical( got,expected );

  test.description = 'multilinedString';
  var got = _._toStrFromStr( 'string\nstring2', { stringWrapper : '`' } );
  var expected = "`string\nstring2`";
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromStr( 2, {} );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromStr( '1', 2 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrFromStr();
    });

  }
}

//

function _toStrFromArray( test )
{

  test.description = 'default options';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 1 } ).text;
  var expected = '[ 1, 2, 3 ]';
  test.identical( got,expected );

  test.description = 'wrap test';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 1, comma : ', ', wrap : 0 } ).text;
  var expected = '   1, 2, 3';
  test.identical( got,expected );

  test.description = 'levels 0 test';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab : '   ', level : 0, levels : 0, comma : ', ', wrap : 1 } ).text;
  var expected = '[ Array with 3 elements ]';
  test.identical( got,expected );

  test.description = 'dtab & multiline test';
  var got = _._toStrFromArray( [ 1, 2, 3 ], { tab : ' ', dtab: '-', level : 0, comma : ', ', wrap : 1, multiline : 1 } ).text;
  var expected =
  [
    '[',
    ' -1, ',
    ' -2, ',
    ' -3',
    ' ]',
  ].join( '\n' );
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromArray( 2, {} );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromArray( [], 2 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrFromArray();
    });

  }
}

//

function _toStrFromObject( test )
{
  var def = { tab : ' ', dtab : '   ',level : 0, levels : 1, onlyEnumerable : 1, own : 1, colon : ' : ', comma : ', ', wrap : 1, noObject : 0, multiline : 0};

  test.description = 'default options';
  var got = _._toStrFromObject( { a : 1, b : 2 , c : 'text' }, def );
  var expected = '{ a : 1, b : 2, c : text }';
  test.identical( got.text,expected );

  test.description = 'levels 0 test';
  def.levels = 0;
  var got = _._toStrFromObject( { a : 1, b : 2 , c : 'text' }, def );
  var expected = '[ Object with 3 elements ]';
  test.identical( got.text,expected );

  test.description = 'wrap 0 test';
  def.levels = 1;
  def.wrap = 0;
  var got = _._toStrFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected = 'a : 1, b : 2, c : text';
  test.identical( got.text,expected );

  test.description = 'noObject test';
  def.noObject = 1;
  var got = _._toStrFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'dtab & prependTab & multiline test';
  def.noObject = 0;
  def.dtab = '*';
  def.multiline  = 1;
  def.prependTab = 1;
  var got = _._toStrFromObject( { a : 1, b : 2, c : 'text' }, def );
  var expected =
  [
    ' *a : 1, ',
    ' *b : 2, ',
    ' *c : text',
  ].join( '\n' );
  test.identical( got.text,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromObject( 1, {} );
    });

    test.description = 'empty options';
    test.shouldThrowError( function()
    {
      _._toStrFromObject( { a : 1 }, {} );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromObject( { a : 1 }, 2 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrFromObject();
    });

  }
}

//

function _toStrFromContainer( test )
{
  var o = { tab : ' ', dtab : '   ',level : 0, levels : 1, onlyEnumerable : 1, own : 1, colon : ' : ', comma : ', ', wrap : 1, noObject : 0, multiline : 0, noSubObject : 0, prependTab : 1, jsonLike : 0, stringWrapper : '"' };
  var src = { a : 1, b : 2, c : 'text' };
  var names = _.mapOwnKeys( src );
  var optionsItem = null;

  function item_options()
  {
  optionsItem = _.mapExtend( {}, o);
  optionsItem.noObject = o.noSubObject ? 1 : 0;
  optionsItem.tab = o.tab + o.dtab;
  optionsItem.level = o.level + 1;
  optionsItem.prependTab = 0;
  };

  test.description = 'default options';
  item_options();
  var got = _._toStrFromContainer
  ({
    values : src,
    names : names,
    optionsContainer : o,
    optionsItem : optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  });
  var expected = ' { a : 1, b : 2, c : "text" }';
  test.identical( got,expected );

  test.description = 'wrap 0,comma ,dtab, multiline test';

  o.wrap = 0;
  o.comma = '_';
  o.dtab = '*';
  o.colon = ' | ';
  o.multiline = 1;
  item_options();

  var got = _._toStrFromContainer
  ({
    values : src,
    names : names,
    optionsContainer : o,
    optionsItem : optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  });
  var expected =
  [
    ' *a | 1_',
    ' *b | 2_',
    ' *c | "text"',
  ].join( '\n' );

  test.identical( got,expected );

  test.description = 'json test';

  o.wrap = 1;
  o.comma = ', ';
  o.dtab = '  ';
  o.multiline = 0;
  o.colon = ' : ';
  o.json = 1;
  o.levels = 256;
  item_options();

  var got = _._toStrFromContainer
  ({
    values : src,
    names : names,
    optionsContainer : o,
    optionsItem : optionsItem,
    simple : !o.multiline,
    prefix : '{',
    postfix : '}',
  });
  var expected = ' { "a" : 1, "b" : 2, "c" : "text" }';

  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid  argument type';
    test.shouldThrowError( function()
    {
      _._toStrFromContainer( 1 );
    });

    test.description = 'empty object';
    test.shouldThrowError( function()
    {
      _._toStrFromContainer( { } );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._toStrFromContainer();
    });

  }
}

//

function strTimes( test )
{
  test.description = 'concatenation test';
  var got = _.strTimes( 'a', 2 );
  var expected = 'aa';
  test.identical( got,expected );

  test.description = 'invalid times value';
  var got = _.strTimes( 'a', -2 );
  var expected = '';
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strTimes( '1' );
    });

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.strTimes( 1,2 );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _.strTimes( '1', '2' );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strTimes();
    });

  }
}

//

function strLineCount( test )
{
  test.description = 'one line string test';
  var got = _.strLineCount( 'one line' );
  var expected = 1;
  test.identical( got,expected );

  test.description = 'multiline string test';
  var got = _.strLineCount( 'first line\nsecond line\nthird line' );
  var expected = 3;
  test.identical( got,expected );

  test.description = 'multiline  text test';
  var got = _.strLineCount( `one
                             two
                             three`
                          );
  var expected = 3;
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strLineCount( '1', '2' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strLineCount( 123 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strLineCount();
    });

  }
}

//

function _strInhalf( test )
{
  test.description = 'three words with comma';
  var got = _._strInhalf( { src : 'one,two,three', delimeter : ',' } );
  var expected = [ 'one,two','three' ];
  test.identical( got,expected );

  test.description = 'array of splitters';
  var got = _._strInhalf( { src : 'one word,two words,three words', delimeter : [ ',',' ' ] } );
  var expected = [ "one word,two words,three", "words" ]
  test.identical( got,expected );

  test.description = 'zero delimeter length';
  var got = _._strInhalf( { src : 'word,word', delimeter : '' } );
  var expected = [ "word,word", "" ];
  test.identical( got,expected );

  test.description = 'left equal zero';
  var got = _._strInhalf( { src : 'word,word_word', delimeter : '_', left : 0 } );
  var expected = [ "word,word", "word" ];
  test.identical( got,expected );

  test.description = 'left 1 & delimeter length equal zero';
  var got = _._strInhalf( { src : 'word,word_word', delimeter : '', left : 1 } );
  var expected = [ "", "word,word_word" ];
  test.identical( got,expected );


  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _._strInhalf( '1', '2' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _._strInhalf( 123 );
    });

    test.description = 'invalid property type';
    test.shouldThrowError( function()
    {
      _._strInhalf( { src : 1 } );
    });

    test.description = 'invalid property type';
    test.shouldThrowError( function()
    {
      _._strInhalf( { src : 'word', delimeter : 0 } );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _._strInhalf();
    });

  }
}

//

function strInhalfLeft( test )
{

  test.description = 'three words with comma';
  var got = _.strInhalfLeft( { src : 'ab,bc,cd', delimeter : ',' } );
  var expected = [ "ab", "bc,cd" ];
  test.identical( got,expected );

  test.description = 'array of splitters';
  var got = _.strInhalfLeft( { src : 'one word,two words,three words', delimeter : [ ',',' ' ] } );
  var expected = [ "one", "word,two words,three words" ];
  test.identical( got,expected );

  test.description = 'zero delimeter length';
  var got = _.strInhalfLeft( { src : 'word,word', delimeter : '' } );
  var expected = [ "", "word,word" ];
  test.identical( got,expected );

  test.description = 'two arguments';
  var got = _.strInhalfLeft( 'word,word_word', '_' );
  var expected = [ "word,word", "word" ];
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft( '1', '2', '3' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft( 123, ' ' );
    });

    test.description = 'delimeter not defined';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft( { src : 1 } );
    });

    test.description = 'invalid property type';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft( { src : 'word', delimeter : 0 } );
    });

    test.description = 'invalid property defined';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft( { src : 'word', delimeter : 0, left : 0 } );
    });

    test.description = 'only one argument provided';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft('one two three ');
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strInhalfLeft();
    });

  }
}

//

function strInhalfRight( test )
{

  test.description = 'three words with comma';
  var got = _.strInhalfRight( { src : 'ab,bc,cd', delimeter : ',' } );
  var expected = [ "ab,bc","cd" ];
  test.identical( got,expected );

  test.description = 'array of splitters';
  var got = _.strInhalfRight( { src : 'one word,two words,three words', delimeter : [ ',',' ' ] } );
  var expected = [ "one word,two words,three", "words" ];
  test.identical( got,expected );

  test.description = 'zero delimeter length';
  var got = _.strInhalfRight( { src : 'word,word', delimeter : '' } );
  var expected = ["word,word", ""]
  test.identical( got,expected );

  test.description = 'two arguments';
  var got = _.strInhalfRight( 'word,word_word', '_' );
  var expected = [ "word,word", "word" ];
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strInhalfRight( '1', '2', '3' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strInhalfRight( 123, ' ' );
    });

    test.description = 'delimeter not defined';
    test.shouldThrowError( function()
    {
      _.strInhalfRight( { src : 1 } );
    });

    test.description = 'invalid property type';
    test.shouldThrowError( function()
    {
      _.strInhalfRight( { src : 'word', delimeter : 0 } );
    });

    test.description = 'invalid property defined';
    test.shouldThrowError( function()
    {
      _.strInhalfRight( { src : 'word', delimeter : 0, left : 1 } );
    });

    test.description = 'only one argument provided';
    test.shouldThrowError( function()
    {
      _.strInhalfRight('one two three ');
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strInhalfRight();
    });

  }
}

//

function strSplit( test )
{

  test.description = 'simple string, defalut options';
  var got = _.strSplit( 'a b c d' );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got,expected );

  test.description = 'arguments as map';
  var got = _.strSplit( { src : 'a,b,c,d', delimeter : ','  } );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got,expected );

  test.description = 'delimeter as array';
  var got = _.strSplit( { src : 'a,b.c.d', delimeter : [ ',', '.' ]  } );
  var expected = [ 'a', 'b', 'c', 'd' ];
  test.identical( got,expected );

  test.description = 'zero delimeter length';
  var got = _.strSplit( { src : 'a,b.c.d', delimeter : []  } );
  var expected = [ 'a,b.c.d' ];
  test.identical( got,expected );

  test.description = 'stripping off';
  var got = _.strSplit( { src : '    a,b,c,d   ', delimeter : [ ',' ], stripping : 0  } );
  var expected = [ '    a', 'b', 'c', 'd   ' ];
  test.identical( got,expected );

  /* */

  test.description = 'preserving delimeters, many delimeters, delimeter on the begin';
  var got = _.strSplit({ src : '.content', preservingDelimeters : 1, delimeter : [ '.','#' ] })
  var expected = [ '.','content' ];
  test.identical( got,expected );

  test.description = 'preserving delimeters, many delimeters, delimeter on the end';
  var got = _.strSplit({ src : 'content.', preservingDelimeters : 1, delimeter : [ '.','#' ] })
  var expected = [ 'content','.' ];
  test.identical( got,expected );

  /* */

  test.description = 'many delimeters having common, preserving empty';
  var src = 'Aa <<! <<- Bb';
  var expected = [ 'Aa',' ','','<<!','',' ','','<<-','',' ','Bb' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
    preservingEmpty : 1,
    preservingDelimeters : 1,
    stripping : 0,
  });
  test.identical( got,expected );
  test.description = 'many delimeters having common, removing empty';
  var src = 'Aa <<! <<- Bb';
  var expected = [ 'Aa',' ','<<!',' ','<<-',' ','Bb' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
    preservingEmpty : 0,
    preservingDelimeters : 1,
    stripping : 0,
  });
  test.identical( got,expected );

  /* */

  test.description = 'having long common';
  var src = 'Aa <<<- Bb';
  var expected = [ 'Aa',' ','','<<<-','',' ','Bb' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
    preservingEmpty : 1,
    preservingDelimeters : 1,
    stripping : 0,
  });
  test.identical( got,expected );

  /* */

  test.description = 'having long common 2';
  var src = 'a1 a2 a3 <<<- Bb';
  var expected = [ 'a1',' ','a2',' ','a3',' ','','<<<-','',' ','Bb' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ '->>>','<<<-','->>','<<-','!>>','<<!','>>','<<',' ' ],
    preservingEmpty : 1,
    preservingDelimeters : 1,
    stripping : 0,
  });
  test.identical( got,expected );

  /*delimeter not exist in src*/

  var src = 'a,b,c';
  var expected = [ 'a,b,c' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ '.' ],
    preservingDelimeters : 1
  });
  test.identical( got, expected );

  /*delimeter not exist in src*/

  var src = 'a,b,c';
  var expected = [ 'a,b,c' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ '.' ],
    preservingDelimeters : 1
  });
  test.identical( got, expected );

  //

  test.description = 'preservingEmpty';

  /**/

  var src = 'a ., b ., c ., d';
  var expected = [ 'a', '', 'b', '', 'c', '', 'd' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : [ ',', '.' ],
    preservingEmpty : 1
  });
  test.identical( got, expected );

  /**/

  var src = 'a , b , c , d';
  var expected = [ 'a', 'b', 'c', 'd' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : ',',
    preservingEmpty : 1
  });
  test.identical( got, expected );


  /**/

  var src = ',';
  var expected = [ '', '' ];
  var got = _.strSplit
  ({
    src : src,
    delimeter : ',',
    preservingEmpty : 1
  });
  test.identical( got, expected );

  /**/

  var src = ',,,';
  var expected = [];
  var got = _.strSplit
  ({
    src : src,
    delimeter : ',',
    preservingEmpty : 0
  });
  test.identical( got, expected );

  /* ignore text inside " " */

  test.description = 'ignore text inside " "';

  var o =
  {
    src : '"/path/with space/" a b c',
    skippingQuotation : 1
  }
  var got = _.strSplit( o );
  var expected = [ '/path/with space/', 'a', 'b', 'c' ];
  test.identical( got, expected );

  /**/

  var o =
  {
    src : 'a "/path with/empty space/" a',
    skippingQuotation : 1
  }
  var got = _.strSplit( o );
  var expected = [ 'a', '/path with/empty space/', 'a' ];
  test.identical( got, expected );

  /**/

  var o =
  {
    src : '"a b c" "a b c" "a b c"',
    skippingQuotation : 1
  }
  var got = _.strSplit( o );
  var expected = [ 'a b c', 'a b c', 'a b c' ];
  test.identical( got, expected );

  /**/

  var o =
  {
    src : '"a b c" "a b c" "a b c"',
    skippingQuotation : 1,
    preservingEmpty : 1
  }
  var got = _.strSplit( o );
  var expected = [ 'a b c', '', 'a b c', '', 'a b c' ];
  test.identical( got, expected );

  /**/

  var o =
  {
    src : '"a b c"x"a b c"x"a b c"',
    skippingQuotation : 1,
    delimeter : [ 'x' ],
    preservingEmpty : 1,
    preservingDelimeters : 1
  }
  var got = _.strSplit( o );
  var expected = [ 'a b c', 'x', 'a b c', 'x', 'a b c' ];
  test.identical( got, expected );

  /**/

  var o =
  {
    src : '"a b" "" c"',
    skippingQuotation : 1,
    delimeter : [ '"' ],
    preservingEmpty : 1,
    preservingDelimeters : 1
  }
  var got = _.strSplit( o );
  var expected = [ 'a b', ' ', ' c"' ];
  test.identical( got, expected );


  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strSplit( '1', '2', '3' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strSplit( 123 );
    });

    test.description = 'invalid property type';
    test.shouldThrowError( function()
    {
      _.strSplit( { src : 'word', delimeter : 0 } );
    });

    test.description = 'invalid property defined';
    test.shouldThrowError( function()
    {
      _.strSplit( { src : 'word', delimeter : 0, left : 1 } );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strSplit();
    });

  }
}

//

function strCutOffLeft( test )
{
  var got,expected;

  //

  test.description = 'single delimeter';

  /**/

  got = _.strCutOffLeft( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( '', [ '' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abc', [ '' ] );
  expected = [ '', '', 'abc' ];
  test.identical( got, expected );

  /* empty delimeters array */

  got = _.strCutOffLeft( 'abca', [] );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( '', 'a' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( '', [ 'a' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abca', 'a' );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abca', [ 'a' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strCutOffLeft( 'abca', 'd' );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strCutOffLeft( 'abca', [ 'd' ] );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  //

  test.description = 'single delimeter, number';

  /*!!!*/

  got = _.strCutOffLeft( 'abca', '', 2 );
  expected = [ 'a', '', 'bca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strCutOffLeft( 'abca', 'a', 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strCutOffLeft( 'abca', [ 'a' ], 2 );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strCutOffLeft( 'abcaca', 'a', 3 );
  expected = [ 'abcac', 'a', '' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strCutOffLeft( 'abcaca', [ 'a' ], 3 );
  expected = [ 'abcac', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abcaca', 'a', 4 );
  expected = [ 'abcaca', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abcaca', [ 'a' ], 4 );
  expected = [ 'abcaca', 'a', '' ];
  test.identical( got, expected );

  //

  test.description = 'several delimeters';

  /**/

  got = _.strCutOffLeft( 'abca', [ 'a', 'c' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abca', [ 'c', 'a' ] );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abca', [ 'x', 'y' ] );
  expected = [ '', '', 'abca'  ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abca', [ 'x', 'y', 'a' ] );
  expected = [ '', 'a', 'bca'  ];
  test.identical( got, expected );

  //

  test.description = 'several delimeters, number';

  /* empty delimeters array */

  got = _.strCutOffLeft( 'abca', [], 2 );
  expected = [ '', '', 'abca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'abcbc', [ 'c', 'a' ], 2 );
  expected = [ 'ab', 'c', 'bc' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'cbcbc', [ 'c', 'a' ], 3 );
  expected = [ 'cbcb', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'cbcbc', [ 'c', 'a' ], 4 );
  expected = [ 'cbcbc', 'c', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'xxx', [ 'c', 'a' ], 4 );
  expected = [ 'xxx', 'c', ''];
  test.identical( got, expected );

  //

  test.description = 'one of delimeters contains other';

  //

  got = _.strCutOffLeft( 'ab', [ 'a', 'ab' ] );
  expected = [ '', 'a', 'b' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'ab', [ 'ab', 'a' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'ab', [ 'b', 'ab' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffLeft( 'ab', [ 'ab', 'b' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  // /**/
  //
  // got = _.strCutOffLeft( 'a b c', ' ', 1 );
  // expected = [ 'a', 'b c' ];
  // test.identical( got, expected );
  //
  // //
  //
  // test.description = 'single delimeter'
  //
  // /* cut on first appear */
  //
  // got = _.strCutOffLeft( 'abca', 'a', 1 );
  // expected = [ '', 'bca' ];
  // test.identical( got ,expected );
  //
  // /* no occurrences */
  //
  // got = _.strCutOffLeft( 'xxx', 'a', 1 );
  // expected = [ '', 'xxx' ];
  // test.identical( got ,expected );
  //
  // /* cut on second appear */
  //
  // got = _.strCutOffLeft( 'abca', 'a', 2 );
  // expected = [ 'abc', '' ];
  // test.identical( got ,expected );
  //
  // /* 5 attempts */
  //
  // got = _.strCutOffLeft( 'abca', 'a', 5 );
  // expected = [ '', 'abca' ];
  // test.identical( got ,expected );
  //
  // //
  //
  // test.description = 'multiple delimeter'
  //
  // /**/
  //
  // got = _.strCutOffLeft( 'abca', [ 'a', 'c' ], 1 );
  // expected = [ '', 'bca' ];
  // test.identical( got ,expected );
  //
  // /**/
  //
  // got = _.strCutOffLeft( 'abca', [ 'a', 'c' ], 2 );
  // expected = [ 'ab', 'a' ];
  // test.identical( got ,expected );
  //
  // /**/
  //
  // got = _.strCutOffLeft( 'abca', [ 'a', 'c' ], 3 );
  // expected = [ '', 'abca' ];
  // test.identical( got ,expected );
  //
  // /* no occurrences */
  //
  // got = _.strCutOffLeft( 'xxx', [ 'a', 'c' ], 1 );
  // expected = [ '', 'xxx' ];
  // test.identical( got ,expected );
  //
  // /* no occurrences */
  //
  // got = _.strCutOffLeft( 'xxx', [ 'a' ], 1 );
  // expected = [ '', 'xxx' ];
  // test.identical( got ,expected );
  //
  // //
  //
  // test.description = 'options as map';
  //
  // /**/
  //
  // got = _.strCutOffLeft({ src : 'abca', delimeter : 'a', number : 1 });
  // expected = [ '', 'bca' ];
  // test.identical( got ,expected );
  //
  // /* number option is missing */
  //
  // got = _.strCutOffLeft({ src : 'abca', delimeter : 'a' });
  // expected = [ '', 'bca' ];
  // test.identical( got ,expected );
  //
  // //
  //
  // test.description = 'number option check';
  //
  // /* number is zero */
  //
  // got = _.strCutOffLeft( 'abca', 'a', 0 );
  // expected = [ '', 'abca' ];
  // test.identical( got ,expected );
  //
  // /* number is negative */
  //
  // got = _.strCutOffLeft( 'abca', 'a', -1 );
  // expected = [ '', 'abca' ];
  // test.identical( got ,expected );
  //
  // if( Config.debug )
  // {
  //   test.description = 'single argument but object expected';
  //   test.shouldThrowErrorSync( function()
  //   {
  //     _.strCutOffLeft( 'abc' );
  //   })
  //
  //   test.description = 'invalid option';
  //   test.shouldThrowErrorSync( function()
  //   {
  //     _.strCutOffLeft({ src : 'abc', delimeter : 'a', query : 'a' });
  //   })
  //
  //   test.description = 'changing of left option not allowed';
  //   test.shouldThrowErrorSync( function()
  //   {
  //     _.strCutOffLeft({ src : 'abc', delimeter : 'a', left : 0 });
  //   })
  // }
}

//

function strCutOffRight( test )
{
  var got,expected;

  //

  test.description = 'single delimeter';

  /**/

  got = _.strCutOffRight( '', '' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( '', [ '' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /*!!!*/

  got = _.strCutOffRight( 'abc', [ '' ] );
  expected = [ 'ab', '', 'c' ];
  test.identical( got, expected );

  /* empty delimeters array */

  got = _.strCutOffRight( 'abca', [] );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( '', 'a' );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( '', [ 'a' ] );
  expected = [ '', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abca', 'a' );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abca', [ 'a' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strCutOffRight( 'abca', 'd' );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /* number 1 by default, no cut, just returns src */

  got = _.strCutOffRight( 'abca', [ 'd' ] );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  //

  test.description = 'single delimeter, number';

  /*!!!*/

  got = _.strCutOffRight( 'abca', '', 2 );
  expected = [ 'ab', '', 'ca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strCutOffRight( 'abca', 'a', 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* cut on second occurrence */

  got = _.strCutOffRight( 'abca', [ 'a' ], 2 );
  expected = [ '', 'a', 'bca' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strCutOffRight( 'abcaca', 'a', 3 );
  expected = [ '', 'a', 'bcaca' ];
  test.identical( got, expected );

  /* cut on third occurrence */

  got = _.strCutOffRight( 'abcaca', [ 'a' ], 3 );
  expected = [ '', 'a', 'bcaca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abcaca', 'a', 4 );
  expected = [ '', '', 'abcaca' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abcaca', [ 'a' ], 4 );
  expected = [ '', '', 'abcaca' ];
  test.identical( got, expected );

  //

  test.description = 'several delimeters';

  /**/

  got = _.strCutOffRight( 'abca', [ 'a', 'c' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abca', [ 'c', 'a' ] );
  expected = [ 'abc', 'a', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abca', [ 'x', 'y' ] );
  expected = [ 'abca', '', ''  ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abca', [ 'x', 'y', 'a' ] );
  expected = [ 'abc', 'a', ''  ];
  test.identical( got, expected );

  //

  test.description = 'several delimeters, number';

  /* empty delimeters array */

  got = _.strCutOffRight( 'abca', [], 2 );
  expected = [ 'abca', '', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abca', [ 'a', 'c' ], 2 );
  expected = [ 'ab', 'c', 'a' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'abcbc', [ 'c', 'a' ], 2 );
  expected = [ 'ab', 'c', 'bc' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'cbcbc', [ 'c', 'a' ], 3 );
  expected = [ '', 'c', 'bcbc' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'cbcbc', [ 'c', 'a' ], 4 );
  expected = [ '', '', 'cbcbc' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'xxx', [ 'c', 'a' ], 4 );
  expected = [ '', 'c', 'xxx' ];
  test.identical( got, expected );

  //

  test.description = 'one of delimeters contains other';

  //

  got = _.strCutOffRight( 'ab', [ 'a', 'ab' ] );
  expected = [ '', 'a', 'b' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'ab', [ 'ab', 'a' ] );
  expected = [ '', 'ab', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'ab', [ 'b', 'ab' ] );
  expected = [ 'a', 'b', '' ];
  test.identical( got, expected );

  /**/

  got = _.strCutOffRight( 'ab', [ 'ab', 'b' ] );
  expected = [ 'a', 'b', '' ];
  test.identical( got, expected );

  // //
  //
  // test.description = 'defaults'
  //
  // /**/
  //
  // got = _.strCutOffRight( 'a b c', ' ', 1 );
  // expected = [ 'a b', 'c' ];
  // test.identical( got, expected );
  //
  // //
  //
  // test.description = 'single delimeter'
  //
  // /* cut on first appear */
  //
  // got = _.strCutOffRight( 'abca', 'a', 1 );
  // expected = [ 'abc', '' ];
  // test.identical( got ,expected );
  //
  // /* no occurrences */
  //
  // got = _.strCutOffRight( 'xxx', 'a', 1 );
  // expected = [ 'xxx', '' ];
  // test.identical( got ,expected );
  //
  // /* cut on second appear */
  //
  // got = _.strCutOffRight( 'abca', 'a', 2 );
  // expected = [ '', 'bca' ];
  // test.identical( got ,expected );
  //
  // /**/
  //
  // got = _.strCutOffRight( 'abca', 'a', 5 );
  // expected = [ 'abca', '' ];
  // test.identical( got ,expected );
  //
  // //
  //
  // test.description = 'multiple delimeter'
  //
  // /**/
  //
  // got = _.strCutOffRight( 'abca', [ 'a', 'c' ], 1 );
  // expected = [ 'abc', '' ];
  // test.identical( got ,expected );
  //
  // /**/
  //
  // got = _.strCutOffRight( 'abca', [ 'a', 'c' ], 2 );
  // expected = [ 'ab', 'a' ];
  // test.identical( got ,expected );
  //
  // /**/
  //
  // got = _.strCutOffRight( 'abca', [ 'a', 'c' ], 3 );
  // expected = [ 'abca', '' ];
  // test.identical( got ,expected );
  //
  // /* no occurrences */
  //
  // got = _.strCutOffRight( 'xxx', [ 'a', 'c' ], 1 );
  // expected = [ 'xxx', '' ];
  // test.identical( got ,expected );
  //
  // /* no occurrences */
  //
  // got = _.strCutOffRight( 'xxx', [ 'a' ], 1 );
  // expected = [ 'xxx', '' ];
  // test.identical( got ,expected );
  //
  // //
  //
  // test.description = 'options as map';
  //
  // /**/
  //
  // got = _.strCutOffRight({ src : 'abca', delimeter : 'a', number : 1 });
  // expected = [ 'abc', '' ];
  // test.identical( got ,expected );
  //
  // /* number option is missing */
  //
  // got = _.strCutOffRight({ src : 'abca', delimeter : 'a' });
  // expected = [ 'abc', '' ];
  // test.identical( got ,expected );
  //
  // //
  //
  // test.description = 'number option check';
  //
  // /* number is zero */
  //
  // got = _.strCutOffRight( 'abca', 'a', 0 );
  // expected = [ 'abca', '' ];
  // test.identical( got ,expected );
  //
  // /* number is negative */
  //
  // got = _.strCutOffRight( 'abca', 'a', -1 );
  // expected = [ 'abca', '' ];
  // test.identical( got ,expected );
  //
  // if( Config.debug )
  // {
  //   test.description = 'single argument but object expected';
  //   test.shouldThrowErrorSync( function()
  //   {
  //     _.strCutOffRight( 'abc' );
  //   })
  //
  //   test.description = 'invalid option';
  //   test.shouldThrowErrorSync( function()
  //   {
  //     _.strCutOffRight({ src : 'abc', delimeter : 'a', query : 'a' });
  //   })
  //
  //   test.description = 'changing of left option not allowed';
  //   test.shouldThrowErrorSync( function()
  //   {
  //     _.strCutOffRight({ src : 'abc', delimeter : 'a', left : 0 });
  //   })
  // }
}

//

function strCutOffAllLeft( test )
{
  var got, expected;

  test.description = 'cut in most right position';

  /* nothing */

  got = _.strCutOffAllLeft( '', 'b' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /* nothing */

  got = _.strCutOffAllLeft( '', '' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllLeft( 'abbbc', 'b' );
  expected = [ 'abb', 'b', 'c' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllLeft( 'abbbc', 'c' );
  expected = [ 'abbb', 'c', '' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllLeft( 'acccb', 'c' );
  expected = [ 'acc', 'c', 'b' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllLeft( 'xxx', 'a' );
  expected = [ '', '', 'xxx' ];
  test.identical( got,expected );

  //

  if( Config.debug )
  {
    test.description = 'delimeter must be a String';
    test.shouldThrowErrorSync( function()
    {
      _.strCutOffAllLeft( 'xxx', 1 );
    })

    test.description = 'source must be a String';
    test.shouldThrowErrorSync( function()
    {
      _.strCutOffAllLeft( 1, '1' );
    })
  }

}

//

function strCutOffAllRight( test )
{
  var got, expected;

  test.description = 'cut in most left position';

  /* nothing */

  got = _.strCutOffAllRight( '', 'b' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /* nothing */

  got = _.strCutOffAllRight( '', '' );
  expected = [ '', '', '' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllRight( 'abbbc', 'b' );
  expected = [ 'a', 'b', 'bbc' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllRight( 'abbbc', 'c' );
  expected = [ 'abbb', 'c', '' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllRight( 'acccb', 'c' );
  expected = [ 'a', 'c', 'ccb' ];
  test.identical( got,expected );

  /**/

  got = _.strCutOffAllRight( 'xxx', 'a' );
  expected = [ 'xxx', '', '' ];
  test.identical( got,expected );

  //

  if( Config.debug )
  {
    test.description = 'delimeter must be a String';
    test.shouldThrowErrorSync( function()
    {
      _.strCutOffAllRight( 'xxx', 1 );
    })

    test.description = 'source must be a String';
    test.shouldThrowErrorSync( function()
    {
      _.strCutOffAllRight( 1, '1' );
    })
  }

}

//

function strStrip( test )
{

  test.description = 'simple string, defalut options';
  var got = _.strStrip( '\nabc  ' );
  var expected = 'abc';
  test.identical( got,expected );

  test.description = 'arguments as map';
  var got = _.strStrip( { src : 'xaabaax', stripper : [ 'a', 'x' ] } );
  var expected = 'b';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strStrip( '1', '2', '3' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strStrip( 123 );
    });

    test.description = 'invalid property type';
    test.shouldThrowError( function()
    {
      _.strStrip( { src : ' word ', delimeter : 0 } );
    });

    test.description = 'invalid property defined';
    test.shouldThrowError( function()
    {
      _.strStrip( { src : ' word ', delimeter : ' ', left : 1 } );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strStrip();
    });

  }
}

//

function strStrip( test )
{
  var cases =
  [
    { description : 'defaults, src is a string' },
    { src : '', expected : '' },
    { src : 'a', expected : 'a' },
    { src : '   a   ', expected : 'a' },
    { src : ' \0 a \0 ', expected : 'a' },
    { src : '\r\n\t\f\v a \v\r\n\t\f', expected : 'a' },

    { description : 'stripper contains regexp special symbols' },
    { src : { src : '\\s\\s', stripper : '\\s' } , expected : '' },
    { src : { src : '(x)(x)', stripper : '(x)' } , expected : '' },
    { src : { src : 'abc', stripper : '[abc]' } , expected : 'abc' },
    { src : { src : '[abc]', stripper : '[abc]' } , expected : '' },
    { src : { src : 'abc', stripper : '[^abc]' } , expected : 'abc' },
    { src : { src : 'abc', stripper : '[a-c]' } , expected : 'abc' },
    { src : { src : '[a-c]', stripper : '[a-c]' } , expected : '' },
    { src : { src : 'ab(a|b)', stripper : '(a|b)' } , expected : 'ab' },
    { src : { src : 'aaa', stripper : 'a+' } , expected : 'aaa' },
    { src : { src : 'bbb', stripper : 'b{3}' } , expected : 'bbb' },
    { src : { src : 'acbc', stripper : '^[ab]c$' } , expected : 'acbc' },

    {
      description : 'defaults, src is an array',
      src :
      [
        '',
        'a',
        '   a   ',
        ' \0 a \0 ',
        '\r\n\t\f\v a \v\r\n\t\f'
      ],
      expected :
      [
        '',
        'a',
        'a',
        'a',
        'a'
      ]
    },
    {
      description : 'src array of strings, custom stripper',
      src :
      {
        src :
        [
          '',
          'a',
          ' a ',
          '  a  ',
          ' \n ',
          ' a b c ',
        ],
        stripper : ' '
      },
      expected :
      [
        '',
        'a',
        'a',
        'a',
        '\n',
        'abc'
      ]
    },
    {
      description : 'src array of strings, custom stripper as regexp',
      src :
      {
        src :
        [
          'x',
          'xx',
          'axbxc',
          'x\nx'
        ],
        stripper : new RegExp( 'x' ),
      },
      expected :
      [
        '',
        'x',
        'abxc',
        '\nx'
      ]
    },
    {
      description : 'src array of strings, custom stripper as regexp',
      src :
      {
        src :
        [
          'abc',
          'acb',
          'bac',
          'cab',
        ],
        stripper : /abc|[abc]/,
      },
      expected :
      [
        '',
        'cb',
        'ac',
        'ab'
      ]
    },
    {
      description : 'src array of strings, custom stripper as regexp',
      src :
      {
        src :
        [
          'abc',
          'acb',
          'bac',
          'bca',
          'cba',
          'cab',
        ],
        stripper : /[abc]/g,
      },
      expected : [ '','','', '', '', '' ]
    },
    {
      description : 'src string, stripper array of strings',
      src :
      {
        src : 'xxxzyyy',
        stripper :
        [
          'x',
          'y',
        ]
      },
      expected : 'z'
    },
    {
      src :
      {
        src : 'xxxyyy',
        stripper :
        [
          'x',
          'y',
        ]
      },
      expected : 'xxxyyy'
    },
    {
      description : 'invalid type',
      args : 0,
      err : true
    },
    {
      description : 'too many arguments',
      args : [ 'a', '' ],
      err : true
    },
    {
      description : 'one string has invalid type',
      args : [ [ 'a', 0, 'b' ] ],
      err : true
    },
    {
      description : 'stripper has invalid type',
      args : [ { src : 'a', stripper : 0 } ],
      err : true
    },
    {
      description : 'stripper has invalid type',
      args : [ { src : 'a', stripper : [ 'a', 0 ]} ],
      err : true
    },
  ]

  /**/

  for( var i = 0; i < cases.length; i++ )
  {
    var c = cases[ i ];
    if( c.description )
    test.description = c.description;

    if( c.err )
    test.shouldThrowError( () => _.strStrip.apply( _, _.arrayAs( c.args ) ) );

    if( c.src )
    test.identical( _.strStrip( c.src ), c.expected )
  }
}

//

function strRemoveAllSpaces( test )
{

  test.description = 'simple string, defalut options';
  var got = _.strRemoveAllSpaces( 'a b c d e' );
  var expected = 'abcde';
  test.identical( got,expected );

  test.description = 'sub defined';
  var got = _.strRemoveAllSpaces( 'a b c d e', ', ' );
  var expected = 'a, b, c, d, e';
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strRemoveAllSpaces( ' ' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'sub as number';
  var got = _.strRemoveAllSpaces( 'a b c', 0 );
  var expected = 'a0b0c';
  test.identical( got,expected );

  test.description = 'sub as array';
  var got = _.strRemoveAllSpaces( 'a b c d e', [ 5, 6 ] );
  var expected = 'a5,6b5,6c5,6d5,6e';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strRemoveAllSpaces( '1', '2', '3' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strRemoveAllSpaces( 123 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strRemoveAllSpaces();
    });

  }
}

//

function strStripEmptyLines( test )
{

  test.description = 'simple string';
  var got = _.strStripEmptyLines( 'line_one\n\nline_two' );
  var expected = 'line_one\nline_two';
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strStripEmptyLines( '' );
  var expected = '';
  test.identical( got,expected );

  test.description = 'single line';
  var got = _.strStripEmptyLines( 'b' );
  var expected = 'b';
  test.identical( got,expected );

  test.description = 'multiple breaklines';
  var got = _.strStripEmptyLines( '\n\na\n\nb\n\n\n' );
  var expected = 'a\nb';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strStripEmptyLines( '1', '2', '3' );
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strStripEmptyLines( 123 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strStripEmptyLines();
    });

  }
}

//

function strReplaceNames( test )
{

  test.description = 'simple string';
  var got = _.strReplaceNames( 'a b c d',[ 'b', 'c' ], [ 'x', 'y' ] );
  var expected = 'a x y d';
  test.identical( got,expected );

  test.description = 'escaping string';
  var got = _.strReplaceNames( '\na b \n c d',[ 'b', 'c' ], [ 'x', 'y' ] );
  var expected = '\na x \n y d';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strReplaceNames( '1', '2');
    });

    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strReplaceNames( 123,[],[] );
    });

    test.description = 'invalid arrays length';
    test.shouldThrowError( function()
    {
      _.strReplaceNames( 'one two',[ 'one' ],[ 'one', 'two' ] );
    });

    test.description = 'invalid second arg type';
    test.shouldThrowError( function()
    {
      _.strReplaceNames( 'one two',5,[ 'one', 'two' ] );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strReplaceNames();
    });

  }
}

//

function strJoin( test )
{

  test.description = 'join numbers';
  var got = _.strJoin( 1, 2, 3 );
  var expected = '123';
  test.identical( got,expected );

  test.description = 'join array + string';
  var got = _.strJoin( [ 1, 2 ], '3' );
  var expected = [ '13', '23' ];
  test.identical( got,expected );

  test.description = 'join two arrays';
  var got = _.strJoin( [ 'b', 'c' ], [ 'x', 'y' ] );
  var expected = [ 'bx', 'cy' ];
  test.identical( got,expected );

  test.description = 'no arguments';
  var got = _.strJoin( );
  var expected = '';
  test.identical( got,expected );

  test.description = 'one argument';
  var got = _.strJoin( '1' );
  var expected = '1';
  test.identical( got,expected );

  test.description = 'different types';
  var got = _.strJoin( 1, '2', [ '3', 4 ], 5, '6' );
  var expected = [ "12356", "12456" ];
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {
    test.description = 'invalid argument type';
    test.shouldThrowError( function()
    {
      _.strJoin( { a : 1 }, [ 1 ], [ 2 ] );
    });

    test.description = 'arrays with different length';
    test.shouldThrowError( function()
    {
      _.strJoin( [ 1, 2 ], [ 1 ], [ 2 ] );
    });

  }
}

//

function strUnjoin( test )
{
  var any = _.strUnjoin.any;

  test.description = 'case 1';
  var got = _.strUnjoin( 'prefix_something_postfix',[ 'prefix', any, 'postfix' ] );
  var expected = [ "prefix", "_something_", "postfix" ];
  test.identical( got,expected );

  test.description = 'case 2a';
  var got = _.strUnjoin( 'prefix_something_postfix',[ any, 'something', 'postfix' ] );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'case 2b';
  var got = _.strUnjoin( 'prefix_something_postfix',[ any, 'something', any, 'postfix' ] );
  var expected = [ "prefix_", "something", '_', "postfix" ];
  test.identical( got,expected );

  test.description = 'case 3a';
  var got = _.strUnjoin( 'prefix_something_postfix', [ 'something', 'postfix', any ] );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'case 3b';
  var got = _.strUnjoin( 'prefix_something_postfix', [ any, 'something', any, 'postfix', any ] );
  var expected = [ "prefix_","something","_", "postfix", "" ];
  test.identical( got,expected );

  test.description = 'case 4';
  var got = _.strUnjoin( 'abc', [ any ] );
  var expected = [ "abc" ];
  test.identical( got,expected );

  test.description = 'case 5';
  var got = _.strUnjoin( 'abc', [ 'a', any ] );
  var expected = [ "a", "bc" ];
  test.identical( got,expected );

  test.description = 'case 6';
  var got = _.strUnjoin( 'abc', [ 'b', any ] );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'case 7';
  var got = _.strUnjoin( 'abc', [ any, 'b' ] );
  var expected = undefined;
  test.identical( got,expected );

  test.description = 'case 7';
  var got = _.strUnjoin( 'abc', [ any, 'c' ] );
  var expected = [ "ab", "c" ];
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strUnjoin( '1', '2', '3' );
    });

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.strUnjoin( 123, [] );
    });

    test.description = 'invalid second arg type';
    test.shouldThrowError( function()
    {
      _.strUnjoin( 'one two', 123 );
    });

    test.description = 'invalid array element type';
    test.shouldThrowError( function()
    {
      _.strUnjoin( 'one two', [ 1, 'two' ] );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strUnjoin();
    });

  }
}

//

function strUnicodeEscape( test )
{

  test.description = 'simple string';
  var got = _.strUnicodeEscape( 'prefix' );
  var expected = "\\u0070\\u0072\\u0065\\u0066\\u0069\\u0078";
  test.identical( got,expected );

  test.description = 'escaping';
  var got = _.strUnicodeEscape( '\npostfix//' );
  var expected = "\\u000a\\u0070\\u006f\\u0073\\u0074\\u0066\\u0069\\u0078\\u002f\\u002f";
  test.identical( got,expected );

  test.description = 'empty string';
  var got = _.strUnicodeEscape( '' );
  var expected = "";
  test.identical( got,expected );



  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strUnicodeEscape( '1', '2', '3' );
    });

    test.description = 'invalid  argument type';
    test.shouldThrowError( function()
    {
      _.strUnicodeEscape( 123 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strUnicodeEscape();
    });

  }
}

//

function strLinesNumber( test )
{
  var got,expected;

  //

  test.description = 'string';

  /**/

  got = _.strLinesNumber( '' );
  expected = '1 : ';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'a' );
  expected = '1 : a';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'a\nb' );
  expected = '1 : a\n2 : b';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'a\nb', 2 );
  expected = '2 : a\n3 : b';
  test.identical( got, expected );

  /**/

  got = _.strLinesNumber( 'line1\nline2\nline3' );
  expected =
  [
    '1 : line1',
    '2 : line2',
    '3 : line3',
  ].join( '\n' );
  test.identical( got,expected );

  /**/

  got = _.strLinesNumber( '\n\n' );
  var expected =
  [
    '1 : ',
    '2 : ',
    '3 : ',
  ].join( '\n' );
  test.identical( got,expected );

  //

  test.description = 'array';

  /**/

  got = _.strLinesNumber( [ 'line1', 'line2', 'line3' ] );
  expected =
  [
    '1 : line1',
    '2 : line2',
    '3 : line3',
  ].join( '\n' );

  /**/

  got = _.strLinesNumber( [ 'line', 'line', 'line' ], 2 );
  expected =
  [
    '2 : line',
    '3 : line',
    '4 : line',
  ].join( '\n' );

  /**/

  got = _.strLinesNumber( [ 'line\n', 'line\n', 'line\n' ] );
  expected =
  [
    '1 : line\n',
    '2 : line\n',
    '3 : line\n',
  ].join( '\n' );

  //

  if( Config.debug )
  {

    test.description = 'invalid  argument type';
    test.shouldThrowError( function()
    {
      _.strLinesNumber( 123 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strLinesNumber();
    });

  }
}

//

function strCount( test )
{

  test.description = 'simple string';
  var got = _.strCount( 'abaac','a' );
  var expected = 3;
  test.identical( got,expected );

  test.description = 'empty src';
  var got = _.strCount( '', 'a' );
  var expected = 0;
  test.identical( got,expected );

  test.description = 'empty substring';
  var got = _.strCount( 'a', '' );
  var expected = 0;
  test.identical( got,expected );



  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strCount( '1', '2', '3' );
    });

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.strCount( 123, '1' );
    });

    test.description = 'invalid second arg type';
    test.shouldThrowError( function()
    {
      _.strCount( 'one two', 123 );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strCount();
    });

  }
}

//

function strDup( test )
{

  test.description = 'simple string';
  var got = _.strDup( 'a', 5 );
  var expected = 'aaaaa';
  test.identical( got,expected );

  test.description = 'one space';
  var got = _.strDup( ' ', 2 );
  var expected = '  ';
  test.identical( got,expected );

  test.description = 'zero times';
  var got = _.strDup( 'a', 0 );
  var expected = '';
  test.identical( got,expected );



  /**/

  if( Config.debug )
  {

    test.description = 'invalid arguments count';
    test.shouldThrowError( function()
    {
      _.strDup( '1', '2', '3' );
    });

    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.strDup( 123, 1 );
    });

    test.description = 'invalid second arg type';
    test.shouldThrowError( function()
    {
      _.strDup( 'one', 'two'  );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strDup();
    });

  }
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


  /**/

  if( Config.debug )
  {

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

  }
}

//

function strMetricFormat( test )
{

  test.description = 'default options';
  var got = _.strMetricFormat( "100m", { } );
  var expected = "100.0 ";
  test.identical( got,expected );

  test.description = 'default options';
  var got = _.strMetricFormat( 0.005 );
  var expected = "5.0 m";
  test.identical( got,expected );

  test.description = 'number to million';
  var got = _.strMetricFormat( 1, { metric : 6 } );
  var expected = "1.0 M";
  test.identical( got,expected );

  test.description = 'metric out of range';
  var got = _.strMetricFormat( 1, { metric : 25 } );
  var expected = "1.0 ";
  test.identical( got,expected );

  test.description = 'fixed : 0';
  var got = _.strMetricFormat( "1300", { fixed : 0 } );
  var expected = "1 k";
  test.identical( got,expected );

  test.description = 'divisor, thousand test';
  var got = _.strMetricFormat( "1000000",{ divisor : 2, thousand:100 } );
  var expected = "1.0 M";
  test.identical( got,expected );

  test.description = 'divisor, thousand,dimensions,metric test';
  var got = _.strMetricFormat( "10000", { divisor : 2, thousand : 10, dimensions : 3,metric: 1 } );
  var expected = '10.0 k'
  test.identical( got,expected );

  test.description = 'divisor, thousand,dimensions test';
  var got = _.strMetricFormat( "10000", { divisor : 2, thousand : 10, dimensions : 3 } );
  var expected = "10.0 h";
  test.identical( got,expected );

  test.description = 'divisor, thousand,dimensions,fixed test';
  var got = _.strMetricFormat( "10000", { divisor : 2, thousand : 10, dimensions : 3, fixed : 0 } );
  var expected = "10 h";
  test.identical( got,expected );



  /**/

  if( Config.debug )
  {

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
      _.strMetricFormat( "1300", { fixed : 22 } );
    });

  }
}

//

function strMetricFormatBytes( test )
{

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

  if( Config.debug )
  {
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
      _.strMetricFormatBytes( "1300", { fixed : 22 } );
    });

  }
}

//

function strTimeFormat( test )
{

  test.description = 'simple number';
  var got = _.strTimeFormat( 1000 );
  var expected = '1.000 s';
  test.identical( got,expected );

  test.description = 'simple number';
  var got = _.strTimeFormat( 1);
  var expected = '1.000 ms';
  test.identical( got,expected );

  test.description = 'number as string';
  var got = _.strTimeFormat( '1.5' );
  var expected = '1.500 ms';
  test.identical( got,expected );

  test.description = 'big number';
  var got = _.strTimeFormat( Math.pow( 4,7 ) );
  var expected = '16.384 s';
  test.identical( got,expected );

  test.description = 'zero';
  var got = _.strTimeFormat( 0 );
  var expected = '0.000 ys';
  test.identical( got,expected );

  test.description = 'empty call';
  var got = _.strTimeFormat(  );
  var expected = 'NaN s';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {

  }
}

//

function strShort( test )
{

  test.description = 'simple string';
  var got = _.strShort( 'string', 4 );
  var expected = '"st" ... "ng"';
  test.identical( got,expected );

  test.description = 'string with escaping';
  var got = _.strShort( 's\ntring', 4 );
  var expected = '"s" ... "ng"';
  test.identical( got,expected );

  test.description = 'limit 0';
  var got = _.strShort( 'string', 0 );
  var expected = 'string';
  test.identical( got,expected );

  test.description = 'limit 1';
  var got = _.strShort( 'string', 1 );
  var expected = '"s"';
  test.identical( got,expected );

  test.description = 'string wih spaces';
  var got = _.strShort( 'str  and', 5 );
  var expected = '"str" ... "nd"';
  test.identical( got,expected );

  test.description = 'one argument call';
  var got = _.strShort( { src : 'string', limit : 4, wrap : "'" } );
  var expected = "'st' ... 'ng'";
  test.identical( got,expected );

  test.description = 'string with whitespaces';
  var got = _.strShort( { src : '  simple string   ', limit : 4, wrap : "'" } );
  var expected = "'  ' ... '  '";
  test.identical( got,expected );

  test.description = 'wrap 0';
  var got = _.strShort( { src : 'simple', limit : 4, wrap : 0 } );
  var expected = "si ... le";
  test.identical( got,expected );

  test.description = 'escaping 0';
  var got = _.strShort( { src : 'si\x01mple', limit : 5, wrap : '"',escaping : 0  } );
  var expected = '"si\x01" ... "le"';
  test.identical( got,expected );

  test.description = 'escaping 1';
  var got = _.strShort( { src : 's\u001btring', limit : 4, wrap : '"' } );
  var expected = '"s" ... "ng"';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {
    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.strShort( 1, 5 );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _.strShort( 'string', '0' );
    });
    // test.description = 'invalid argument type( not a Object )';
    // test.shouldThrowError( function()
    // {
    //   _.strShort( 'src' );
    // });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strShort();
    });

    test.description = 'unknown property provided';
    test.shouldThrowError( function()
    {
      _.strShort( { src : 'string', limit : 4, wrap : 0, fixed : 5 } );
    });

  }
}

//

function strLinesSelect( test )
{
  var got,expected;
  var src = 'a\nb\nc\nd';

  //

  test.description = 'single line selection';

  /**/

  got = _.strLinesSelect( '', 1 );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( 'abc', 1 );
  expected = 'abc';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( 'abc', 0 );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, 1 );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, 2 );
  expected = 'b';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, -1 );
  expected = '';
  test.identical( got, expected );

  /* line number bigger then actual count of lines */

  got = _.strLinesSelect( src, 99 );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, 1, 2 );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 2 ] );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ -1, 2 ] );
  expected = 'a';
  test.identical( got, expected );



  //

  test.description = 'multiline selection';

  /**/

  got = _.strLinesSelect( src, [ -1, -1 ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( '', [ 1, 3 ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 3 ] );
  expected = 'a\nb';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ -1, 2 ] );
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 4 ] );
  expected = 'a\nb\nc';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 99, 4 ] );
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 1, 99 ] );
  expected = src;
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect( src, [ 2, 5 ] );
  expected = 'b\nc\nd';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect({ src : src, range : [ 2, 5 ], zero : 4 });
  expected = 'a';
  test.identical( got, expected );

  //

  test.description = 'selection without range provided, selectMode : center';

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 2,
    numberOfLines : 3,
    selectMode : 'center',
    zero : 1
  });
  expected = 'a\nb\nc';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 3,
    selectMode : 'center',
    zero : 1
  });
  expected = 'a\nb';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 1,
    selectMode : 'center',
    zero : 1
  });
  expected = 'a';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 99,
    selectMode : 'center',
    zero : 1
  });
  expected = src;
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : -1,
    selectMode : 'center',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 0,//same behavior as null?
    numberOfLines : 1,
    selectMode : 'center',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  got = _.strLinesSelect
  ({
    src : '',
    line : 1,
    numberOfLines : 1,
    selectMode : 'center',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  //

  test.description = 'selection without range provided, selectMode : begin';

  /*two lines from begining of the string*/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 2,
    selectMode : 'begin',
    zero : 1
  });
  expected = 'a\nb';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : -1,
    numberOfLines : 2,
    selectMode : 'begin',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 0,
    selectMode : 'begin',
    zero : 1
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 99,
    selectMode : 'begin',
    zero : 1
  });
  expected = src;
  test.identical( got, expected );

  /* zero > range[ 0 ] */

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 5,
    selectMode : 'begin',
    zero : 2
  });
  expected = src;
  test.identical( got, expected );

  //

  test.description = 'selection without range provided, selectMode : end';

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 4,
    numberOfLines : 2,
    selectMode : 'end'
  });
  expected = 'c\nd';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : -1,
    numberOfLines : 2,
    selectMode : 'end'
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 0,
    selectMode : 'end'
  });
  expected = '';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 99,
    selectMode : 'end'
  });
  expected = 'a';
  test.identical( got, expected );

  /* zero > range[ 0 ] */

  got = _.strLinesSelect
  ({
    src : src,
    line : 1,
    numberOfLines : 5,
    selectMode : 'end',
    zero : 2
  });
  expected = '';
  test.identical( got, expected );

  //

  test.description = 'custom new line'
  var src2 = 'a b c d'

  /**/

  got = _.strLinesSelect
  ({
    src : src2,
    range : [ 1, 3 ],
    nl : ' '
  });
  expected = 'a b';
  test.identical( got, expected );

  /**/

  got = _.strLinesSelect
  ({
    src : src2,
    range : [ 1, 3 ],
    nl : 'x'
  });
  expected = src2;
  test.identical( got, expected );

  //

  test.description = 'number'

  /**/

  got = _.strLinesSelect
  ({
    src : src,
    range : [ 1, 3 ],
    number : 1
  });
  expected = '1 : a\n2 : b';
  test.identical( got, expected );

  //

  var src =
  `Lorem
  ipsum dolor
  sit amet,
  consectetur
  adipisicing
  elit`;

  //

  test.description = 'first line';
  var got = _.strLinesSelect( src, 1 );
  var expected = 'Lorem';
  test.identical( got,expected );

  //

  test.description = 'first two lines';
  var got = _.strLinesSelect( src, 1, 3 );
  var expected =
  `Lorem
  ipsum dolor`;
  test.identical( got,expected );

  //

  test.description = 'range as array';
  var got = _.strLinesSelect( src, [ 1, 3 ] );
  var expected =
  `Lorem
  ipsum dolor`;
  test.identical( got,expected );

  //

  test.description = 'custom new line';
  var src2 ='Lorem||ipsum dolor||sit amet||consectetur'
  var got = _.strLinesSelect( { src :  src2, range : [ 3, 5 ], nl : '||' } );
  var expected = `sit amet||consectetur`;
  test.identical( got,expected );

  //

  test.description = 'empty line, out of range';
  var got = _.strLinesSelect( { src :  '', range : [ 1, 1 ] } );
  var expected = '';
  test.identical( got,expected );

  //

  test.description = 'empty line';
  var got = _.strLinesSelect( { src :  '', range : [ 0, 1 ] } );
  var expected = '';
  test.identical( got,expected );

  //

  test.description = 'incorrect range';
  var got = _.strLinesSelect( { src :  src, range : [ 2, 1 ] } );
  var expected = '';
  test.identical( got,expected );

  /**/

  if( Config.debug )
  {
    test.description = 'invalid first argument type';
    test.shouldThrowError( function()
    {
      _.strLinesSelect( 1, 1 );
    });

    test.description = 'invalid second argument type';
    test.shouldThrowError( function()
    {
      _.strLinesSelect( 'lorem\nipsum\n', 'second'  );
    });

    test.description = 'no arguments';
    test.shouldThrowError( function()
    {
      _.strLinesSelect( );
    });

    test.description = 'unknown property provided';
    test.shouldThrowError( function()
    {
      _.strLinesSelect( { src : 'lorem\nipsum\n', range : [ 0, 1 ], x : 1 } );
    });
  }
}

//

function strCommonLeft( test )
{
  test.description = 'no args';
  var got = _.strCommonLeft( );
  var expected = '';
  test.identical( got, expected );

  test.description = 'one argument';
  var got = _.strCommonLeft( 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.description = 'ins is empty string';
  var got = _.strCommonLeft( '', 'a', 'b' );
  var expected = '';
  test.identical( got, expected );

  test.description = 'several strings';
  var got = _.strCommonLeft( 'abc', 'abd', 'abc', 'ada' );
  var expected = 'a';
  test.identical( got, expected );

  test.description = 'one string is empty';
  var got = _.strCommonLeft( 'abc', '', 'abc', 'ada' );
  var expected = '';
  test.identical( got, expected );

  if( Config.debug )
  {
    test.description = 'ins is array';
    test.shouldThrowError( function( )
    {
      _.strCommonLeft( ['a','b','c'], 'abd', 'abc', 'ada' );
    });
  }
}

//

function strCommonRight( test )
{
  test.description = 'no args';
  var got = _.strCommonRight( );
  var expected = '';
  test.identical( got, expected );

  test.description = 'one argument';
  var got = _.strCommonRight( 'abc' );
  var expected = 'abc';
  test.identical( got, expected );

  test.description = 'ins is empty string';
  var got = _.strCommonRight( '', 'a', 'b' );
  var expected = '';
  test.identical( got, expected );

  test.description = 'several strings';
  var got = _.strCommonRight( 'a', 'cba', 'dba', 'ada' );
  var expected = 'a';
  test.identical( got, expected );

  test.description = 'one string is empty';
  var got = _.strCommonRight( 'abc', '', 'abc', 'ada' );
  var expected = '';
  test.identical( got, expected );

  if( Config.debug )
  {
    test.description = 'ins is array';
    test.shouldThrowError( function( )
    {
      _.strCommonRight( ['a','b','c'], 'abd', 'abc', 'ada' );
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

//

var Self =
{

  name : 'StringTools tests 2',
  silencing : 1,

  tests :
  {

    strCapitalize : strCapitalize,
    strReplaceAll : strReplaceAll,

    strHtmlEscape : strHtmlEscape,
    strIndentation : strIndentation,
    strCamelize : strCamelize,
    strFilenameFor : strFilenameFor,
    toStrMethods : toStrMethods,
    toStrFields : toStrFields,

    _toStrShort : _toStrShort,
    _toStrIsVisibleElement : _toStrIsVisibleElement,
    _toStrIsSimpleElement : _toStrIsSimpleElement,
    _toStrFromRoutine : _toStrFromRoutine,
    _toStrFromNumber : _toStrFromNumber,
    _toStrFromStr : _toStrFromStr,
    _toStrFromArray : _toStrFromArray,
    _toStrFromObject : _toStrFromObject,
    _toStrFromContainer : _toStrFromContainer,
    _toStrFromContainer : _toStrFromContainer,

    strTimes : strTimes,
    strLineCount : strLineCount,
    _strInhalf : _strInhalf,
    strInhalfLeft : strInhalfLeft,
    strInhalfRight : strInhalfRight,

    strSplit : strSplit,

    strCutOffLeft : strCutOffLeft,
    strCutOffRight : strCutOffRight,
    strCutOffAllLeft : strCutOffAllLeft,
    strCutOffAllRight : strCutOffAllRight,

    strStrip : strStrip,
    strRemoveAllSpaces : strRemoveAllSpaces,
    strStripEmptyLines : strStripEmptyLines,
    strReplaceNames : strReplaceNames,
    strJoin : strJoin,
    strUnjoin : strUnjoin,
    strUnicodeEscape : strUnicodeEscape,
    strLinesNumber : strLinesNumber,
    strCount : strCount,
    strDup : strDup,
    strToBytes : strToBytes,
    strMetricFormat : strMetricFormat,
    strMetricFormatBytes : strMetricFormatBytes,
    strTimeFormat : strTimeFormat,
    strShort : strShort,
    strLinesSelect : strLinesSelect,
    strCommonLeft : strCommonLeft,
    strCommonRight : strCommonRight,
    strExtractStrips : strExtractStrips,
    strExtractStereoStrips : strExtractStereoStrips,

    strSorterParse : strSorterParse,

  }

}

Self = wTestSuit( Self );
if( typeof module !== 'undefined' && !module.parent )
_.Tester.test( Self.name );

})();
