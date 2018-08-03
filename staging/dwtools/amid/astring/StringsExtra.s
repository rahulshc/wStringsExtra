(function _StringExtra_s_() {

'use strict';

/**
  @module Tools/base/StringToolsExtra - Collection of sophisticated routines for operations on Strings. StringsToolsExtra leverages analyzing, parsing and formatting of String for special purposes.
*/

/**
 * @file StringToolsExtra.s.
 */

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

  _.include( 'wArraySorted' );

}

//

var Self = _global_.wTools;
var _ = _global_.wTools;

var _ArraySlice = Array.prototype.slice;
var _FunctionBind = Function.prototype.bind;
var _ObjectToString = Object.prototype.toString;
var _ObjectHasOwnProperty = Object.hasOwnProperty;

// var __assert = _.assert;
var _arraySlice = _.longSlice;
var strTypeOf = _.strTypeOf;

_.assert( _.routineIs( _.arraySortedAddOnce ) );

// --
//
// --

/**
 * Converts string to camelcase using special pattern.
 * If function finds character from this( '.','-','_','/' ) list before letter,
 * it replaces letter with uppercase version.
 * For example: '.an _example' or '/an -example', method converts string to( 'An Example' ). *
 *
 * @param {string} srcStr - Source string.
 * @returns {string} Returns camelcase version of string.
 *
 * @example
 * //returns aBCD
 * _.strCamelize( 'a-b_c/d' );
 *
 * @example
 * //returns testString
 * _.strCamelize( 'test-string' );
 *
 * @method strCamelize
 * @throws { Exception } Throws a exception if( srcStr ) is not a String.
 * @throws { Exception } Throws a exception if no argument provided.
 * @memberof wTools
 *
 */

function strCamelize( srcStr )
{
  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( srcStr ) );

  var result = srcStr;
  var regexp = /\.\w|-\w|_\w|\/\w/g;

  var result = result.replace( regexp,function( match )
  {
    return match[ 1 ].toUpperCase();
  });

  return result;
}

//

/**
 * Removes invalid characters from filename passed as first( srcStr ) argument by replacing characters finded by
 * pattern with second argument( o ) property( o.delimeter ).If( o.delimeter ) is not defined,
 * function sets value to( '_' ).
 *
 * @param {string} srcStr - Source string.
 * @param {object} o - Object that contains o.
 * @returns {string} Returns string with result of replacements.
 *
 * @example
 * //returns _example_file_name.txt
 * _.strFilenameFor( "'example\\file?name.txt" );
 *
 * @example
 * //returns #example#file#name.js
 * var o = { 'delimeter':'#' };
 * _.strFilenameFor( "'example\\file?name.js",o );
 *
 * @method strFilenameFor
 * @throws { Exception } Throws a exception if( srcStr ) is not a String.
 * @throws { Exception } Throws a exception if( o ) is not a Map.
 * @throws { Exception } Throws a exception if no arguments provided.
 * @memberof wTools
 *
 */

function strFilenameFor( o )
{
  if( _.strIs( o ) )
  o = { srcString : o }

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( o.srcString ) );
  _.routineOptions( strFilenameFor,o );

  var regexp = /<|>|:|"|'|\/|\\|\||\&|\?|\*|\n|\s/g;
  var result = o.srcString.replace( regexp,function( match )
  {
    return o.delimeter;
  });

  return result;
}

strFilenameFor.defaults =
{
  srcString : null,
  delimeter : '_',
}

//

function strVarNameFor( o )
{
  if( _.strIs( o ) )
  o = { src : o }

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( o.src ) );
  _.routineOptions( strVarNameFor,o );

  var regexp = /\.|\-|\+|<|>|:|"|'|\/|\\|\||\&|\?|\*|\n|\s/g;
  var result = o.src.replace( regexp,function( match )
  {
    return o.delimeter;
  });

  return result;
}

strVarNameFor.defaults =
{
  src : null,
  delimeter : '_',
}

//

/**
 * @name _strHtmlEscapeMap
 * @type {object}
 * @description Html escape symbols map.
 * @global
 */

var _strHtmlEscapeMap =
{
  '&' : '&amp;',
  '<' : '&lt;',
  '>' : '&gt;',
  '"' : '&quot;',
  '\'' : '&#39;',
  '/' : '&#x2F;'
}

/**
 * Replaces all occurrences of html escape symbols from map( _strHtmlEscapeMap )
 * in source( str ) with their code equivalent like( '&' -> '&amp;' ).
 * Returns result of replacements as new string or original if nothing replaced.
 *
 * @param {string} str - Source string to parse.
 * @returns {string} Returns string with result of replacements.
 *
 * @example
 * //returns &lt;&amp;test &amp;text &amp;here&gt;
 * _.strHtmlEscape( '<&test &text &here>' );
 *
 * @example
 * //returns 1 &lt; 2
 * _.strHtmlEscape( '1 < 2' );
 *
 * @example
 * //returns &#x2F;&#x2F;test&#x2F;&#x2F;
 * _.strHtmlEscape( '//test//' );
 *
 * @example
 * //returns &amp;,&lt;
 * _.strHtmlEscape( ['&','<'] );
 *
 * @example
 * //returns &lt;div class=&quot;cls&quot;&gt;&lt;&#x2F;div&gt;
 * _.strHtmlEscape('<div class="cls"></div>');
 *
 * @method strHtmlEscape
 * @throws { Exception } Throws a exception if no argument provided.
 * @memberof wTools
 *
 */

function strHtmlEscape( str )
{
  _.assert( arguments.length === 1, 'expects single argument' );

  return String( str ).replace( /[&<>"'\/]/g, function( s )
  {
    return _strHtmlEscapeMap[ s ];
  });
}

//
//
// xxx
// function strToRegexpTolerating( src )
// {
//   var result = src;
//
//   _.assert( arguments.length === 1, 'expects single argument' );
//   _.assert( _.strIs( src ) || _.regexpIs( src ) );
//
//   if( _.strIs( src ) )
//   {
//
//     var optionsExtract =
//     {
//       prefix : '>->',
//       postfix : '<-<',
//       src : src,
//     }
//
//     var strips = _.strExtractInlinedStereo( optionsExtract );
//
//     for( var s = 0 ; s < strips.length ; s++ )
//     {
//       var strip = strips[ s ];
//
//       if( s % 2 === 0 )
//       {
//         strip = _.regexpEscape( strip );
//         strip = strip.replace( /\s+/g,'\\s*' );
//       }
//
//       strips[ s ] = strip;
//     }
//
//     result = RegExp( strips.join( '' ),'g' );
//   }
//
//   return result;
// }
//
//
//
// xxx
// function strToRegexp( src )
// {
//   var result = [];
//
//   _.assert( arguments.length === 1, 'expects single argument' );
//   _.assert( _.strIs( src ) || _.regexpIs( src ) );
//
//   if( _.strIs( src ) )
//   {
//     src = _.regexpEscape( src );
//     src = RegExp( src,'g' );
//   }
//
//   return src;
// }
//
//

function strFind( o )
{
  var result = [];

  _.assert( arguments.length === 1, 'expects single argument' );
  _.routineOptions( strFind,o );

  /* */

  o.ins = _.arrayAs( o.ins );
  o.ins = _.regexpsMaybeFrom
  ({
    srcStr : o.ins,
    stringWithRegexp : o.stringWithRegexp,
    toleratingSpaces : o.toleratingSpaces,
  });

  /* */

  function findForIns( ins )
  {

    do
    {
      var execed = ins.exec( o.src );
      if( execed )
      {
        var r = Object.create( null );

        r.ins = execed[ 0 ];
        r.inss = _.longSlice( execed,1 );
        r.charsRange = [ execed.index, execed.index + r.ins.length ];
        r.charsRangeRight = [ o.src.length - execed.index, o.src.length - execed.index - r.ins.length ];

        if( o.determiningLineNumber )
        {
          var first = o.src.substring( 0,r.charsRange[ 0 ] ).split( '\n' ).length;
          r.linesRange = [ first, first+o.src.substring( r.charsRange[ 0 ], r.charsRange[ 1 ] ).split( '\n' ).length ];
        }

        if( o.nearestLines )
        r.nearest = _.strLinesNearest
        ({
          src : o.src,
          charsRange : r.charsRange,
          numberOfLines : o.nearestLines,
        });

        r.linesOffsets = [ first - _.strLinesCount( r.nearest[ 0 ] ) + 1, first, first + _.strLinesCount( r.nearest[ 1 ] ) ];

        if( !o.nearestSplitting )
        r.nearest.join( '' );

        result.push( r );
      }

    }
    while( execed );

  }

  /* */

  for( var i = 0 ; i < o.ins.length ; i++ )
  findForIns( o.ins[ i ] );

  /* */

  if( o.ins.length <= 1 )
  return result;

  var result = _.arraySort( result,function( e )
  {
    return e.charsRange[ 0 ];
  });

  for( var i1 = 0 ; i1 < result.length-1 ; i1++ )
  {
    var r1 = result[ i1 ];
    do
    {
      var r2 = result[ i1+1 ];

      if( r1.charsRange[ 1 ] > r2.charsRange[ 0 ] )
      debugger;

      if( r1.charsRange[ 1 ] > r2.charsRange[ 0 ] )
      result.splice( i1+1,i1+2 );
      else
      break;
    }
    while( true )
  }

  return result;
}

strFind.defaults =
{
  src : null,
  ins : null,
  onIns : null,
  nearestLines : 3,
  nearestSplitting : 1,
  determiningLineNumber : 0,
  stringWithRegexp : 0,
  toleratingSpaces : 0,
}

//

function strSorterParse( o )
{

  if( arguments.length === 1 )
  {
    if( _.strIs( o ) )
    o = { src : o }
  }

  if( arguments.length === 2 )
  {
    o =
    {
      src : arguments[ 0 ],
      fields : arguments[ 1 ]
    }
  }

  _.routineOptions( strSorterParse, o );
  _.assert( o.fields === null || _.objectLike( o.fields ) );
  _.assert( arguments.length === 1 || arguments.length === 2 );

  var map =
  {
    '>' : 1,
    '<' : 0
  }

  var delimeters = _.mapOwnKeys( map );
  var splitted = _.strSplit/**1**/
  ({
    src : o.src,
    delimeter : delimeters,
    stripping : 1,
    preservingDelimeters : 1,
    preservingEmpty : 0,
  });

  var parsed = [];

  if( splitted.length >= 2 )
  for( var i = 0; i < splitted.length; i+= 2 )
  {
    var field = splitted[ i ];
    var postfix = splitted[ i + 1 ];

    _.assert( o.fields ? o.fields[ field ] : true, 'Field: ', field, ' is not allowed.' );
    _.assert( _.strIs( postfix ), 'Field: ', field, ' doesn\'t have a postfix.' );

    var valueForPostfix = map[ postfix ];

    if( valueForPostfix !== undefined )
    {
      parsed.push( [ field,valueForPostfix ] )
    }
    else
    {
      _.assert( 0, 'unknown postfix: ', postfix )
    }
  }

  return parsed;
}

strSorterParse.defaults =
{
  src : null,
  fields : null,
}

//

/**
 * Replaces each occurrence of string( ins ) in source( src ) with string( sub ).
 * Returns result of replacements as new string or original string if no matches finded in source( src ).
 * Function can be called in three different ways:
 * - One argument: object that contains options: source( src ) and dictionary.
 * - Two arguments: source string( src ), map( dictionary ).
 * - Three arguments: source string( src ), pattern string( ins ), replacement( sub ).
 * @param {string} src - Source string to parse.
 * @param {string} ins - String to find in source( src ).
 * @param {string} sub - String that replaces finded occurrence( ins ).
 * @param {object} dictionary - Map that contains pattern/replacement pairs like ( { 'ins' : 'sub' } ).
 * @returns {string} Returns string with result of replacements.
 *
 * @example
 * //one argument
 * //returns xbc
 * _.strReplaceAll( { src : 'abc', dictionary : { 'a' : 'x' } } );
 *
 * @example
 * //two arguments
 * //returns a12
 * _.strReplaceAll( 'abc',{ 'a' : '1', 'b' : '2' } );
 *
 * @example
 * //three arguments
 * //returns axc
 * _.strReplaceAll( 'abc','b','x' );
 *
 * @method strReplaceAll
 * @throws { Exception } Throws a exception if no arguments provided.
 * @throws { Exception } Throws a exception if( src ) is not a String.
 * @throws { Exception } Throws a exception if( ins ) is not a String.
 * @throws { Exception } Throws a exception if( sub ) is not a String.
 * @throws { Exception } Throws a exception if( dictionary ) is not a Object.
 * @throws { Exception } Throws a exception if( dictionary ) key value is not a String.
 * @memberof wTools
 *
 */

function strReplaceAll( src, ins, sub )
{

  var o;

  if( arguments.length === 3 )
  {
    o = { src : src };
    o.dictionary = [ [ ins, sub ] ]
  }
  else if( arguments.length === 2 )
  {
    o = { src : arguments[ 0 ] , dictionary : arguments[ 1 ] };
  }
  else if( arguments.length === 1 )
  {
    o = arguments[ 0 ];
  }

  /**/

  _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
  _.assert( _.strIs( o.src ) );
  _.assert( _.objectIs( o.dictionary ) || _.arrayLike( o.dictionary ));
  _.routineOptions( strReplaceAll, o );

  /**/

  var foundArray = [];
  var src = o.src;

  /* */

  if( _.objectIs( o.dictionary ) )
  {
    for( var ins in o.dictionary )
    {
      replaceWithString( src, ins, o.dictionary[ ins ] );
    }
  }
  else if( _.arrayLike( o.dictionary ) )
  {
    for( var p = 0; p < o.dictionary.length; p++ )
    {

      var pair = o.dictionary[ p ];
      var ins = _.arrayAs( pair[ 0 ] );
      var sub = _.arrayAs( pair[ 1 ] );

      _.assert( _.arrayLike( o.dictionary[ p ] ) );
      _.assert( pair.length === 2 );
      _.assert( ins.length === sub.length );

      for( var i = 0; i < ins.length; i++ )
      {
        _.assert( _.strIs( ins[ i ] ) || _.regexpIs( ins[ i ] ) );

        if( _.strIs( ins[ i ] ) )
        {
          if( !ins.length )
          continue;
          replaceWithString( src, ins[ i ], sub[ i ] );
        }
        else
        {
          replaceWithRegexp( src, ins[ i ], sub[ i ] );
        }

      }
    }
  }

  /* */

  var result = '';
  var index = 0;
  for( var f = 0 ; f < foundArray.length ; f++ )
  {
    var fo = foundArray[ f ];
    result += src.substring( index, fo[ 0 ] );
    result += fo[ 3 ];
    index = fo[ 1 ];
  }

  result += src.substring( index, src.length );

  return result

  /* */

  function replaceWithRegexp( src, ins, sub )
  {

    if( _.routineIs( sub ) )
    {
      src.replace( ins, handleReplaceWithRoutine( sub ) );
    }
    else
    {
      src.replace( ins, handleReplaceWithString( sub ) );
    }

  }

  /* */

  function replaceWithString( src, ins, sub )
  {
    _.assert( _.strIs( sub ) || _.routineIs( sub ), 'expects string or routine {-sub-}' );

    if( !ins.length )
    return src;

    var index2 = 0;
    var index = src.indexOf( ins );
    while( index >= 0 )
    {

      var f = found( index, ins, sub );

      var subStr = sub;
      if( f )
      if( _.routineIs( sub ) )
      {
        var it = Object.create( null );
        it.match = src.substring( index, index + ins.length );
        it.range = [ index, index + it.match.length ];
        it.counter = o.counter;
        it.input = src;
        it.groups = [];
        subStr = sub( it.match, it );
        _.assert( _.strIs( subStr ), 'expects string' );
        f[ 3 ] = subStr;
      }

      if( f )
      {
        index += ins.length;
        o.counter += 1;
      }
      else
      {
        index += 1;
      }

      index2 = index;
      index = src.indexOf( ins, index );

    }

  }

  /* */

  function intersects( ins1, ins2 )
  {
    if( ins2[ 1 ] <= ins1[ 0 ] )
    return false;
    if( ins1[ 1 ] <= ins2[ 0 ] )
    return false;
    return true;
  }

  /* */

  function comparator( ins1, ins2 )
  {
    if( intersects( ins1, ins2 ) )
    return 0;
    return ins1[ 0 ] - ins2[ 0 ];
  }

  /* */

  function found( index, ins, sub )
  {
    var f = [ index, index + ins.length, ins, sub ];
    if( _.arraySortedAddOnce( foundArray, f, comparator ) )
    return f;
    else
    return null;
  }

  /* */

  function handleReplaceWithRoutine( callback )
  {
    function adapt()
    {
      var f = found( arguments[ arguments.length - 2 ], arguments[ 0 ], null );
      if( !f )
      return f;
      var it = Object.create( null );
      it.match = arguments[ 0 ];
      it.range = [ arguments[ arguments.length - 2 ], arguments[ arguments.length - 2 ] + it.match.length ];
      it.counter = o.counter;
      it.input = arguments[ arguments.length - 1 ];
      it.groups = _.longSlice( arguments, 1, arguments.length-2 );
      var subStr = callback( it.match, it );
      o.counter += 1;
      _.assert( _.strIs( subStr ), 'expects string' );
      f[ 3 ] = subStr;
      return f;
    }
    return adapt;
  }

  /* */

  function handleReplaceWithString( subStr )
  {
    _.assert( _.strIs( subStr ), 'expects string' );
    function adapt()
    {
      var f = found( arguments[ arguments.length - 2 ], arguments[ 0 ], null );
      if( !f )
      return f;
      o.counter += 1;
      f[ 3 ] = subStr;
      return f;
    }
    return adapt;
  }

}

strReplaceAll.defaults =
{
  src : null,
  dictionary : null,
  counter : 0,
}

// //
//
// function strReplaceAll( src, ins, sub )
// {
//   var o;
//   _.assert( arguments.length === 1 || arguments.length === 2 || arguments.length === 3 );
//
//   if( arguments.length === 3 )
//   {
//     o = { src : src };
//     o.dictionary = [ [ ins, sub ] ]
//   }
//   else if( arguments.length === 2 )
//   {
//     o = { src : src , dictionary : arguments[ 1 ] };
//   }
//   else if( arguments.length === 1 )
//   {
//     o = arguments[ 0 ];
//   }
//
//   /**/
//
//   _.assert( _.strIs( o.src ) );
//   _.assert( _.objectIs( o.dictionary ) || _.longIs( o.dictionary ));
//
//   /**/
//
//   var index = 0;
//
//   function replace( src, ins, sub )
//   {
//     _.assert( _.strIs( sub ), 'strReplaceAll : expects sub as string' );
//
//     if( !ins.length )
//     return src;
//
//     do
//     {
//       var index = src.indexOf( ins,index );
//       if( index >= 0 )
//       {
//         src = src.substring( 0,index ) + sub + src.substring( index+ins.length );
//         index += sub.length;
//       }
//       else
//       break;
//
//     }
//     while( 1 );
//
//     return src;
//   }
//
//   var src = o.src;
//
//   /* */
//
//   if( _.objectIs( o.dictionary ) )
//   {
//     for( var ins in o.dictionary )
//     {
//       if( !ins.length ) continue;
//       src = replace( src, ins, o.dictionary[ ins ] );
//     }
//   }
//   else if( _.longIs( o.dictionary ) )
//   {
//     for( var p = 0; p < o.dictionary.length; p++ )
//     {
//       _.assert( _.longIs( o.dictionary[ p ] ) );
//
//       var pair = o.dictionary[ p ];
//
//       _.assert( pair.length === 2 );
//
//       var ins = _.arrayAs( pair[ 0 ] );
//       var sub = _.arrayAs( pair[ 1 ] );
//
//       _.assert( ins.length === sub.length );
//
//       for( var i = 0; i < ins.length; i++ )
//       {
//         _.assert( _.strIs( ins[ i ] ) || _.regexpIs( ins[ i ] ) );
//
//         if( _.strIs( ins[ i ] ) )
//         {
//           if( !ins.length ) continue;
//           src = replace( src, ins[ i ], sub[ i ] );
//         }
//         else
//         {
//           src = src.replace( ins[ i ], sub[ i ] );
//         }
//       }
//     }
//   }
//
//   return src;
//   //return src.replace( new RegExp( _.regexpEscape( ins ),'gm' ), sub );
// }
//
// strReplaceAll.defaults =
// {
//   src : null,
//   dictionary : null,
// }

// --
// format
// --

/**
 * Converts string( str ) to array of unsigned 8-bit integers.
 *
 * @param {string} str - Source string to convert.
 * @returns {typedArray} Returns typed array that represents string characters in 8-bit unsigned integers.
 *
 * @example
 * //returns [ 101, 120, 97, 109, 112, 108, 101 ]
 * _.strToBytes( 'example' );
 *
 * @method strToBytes
 * @throws { Exception } Throws a exception if( src ) is not a String.
 * @throws { Exception } Throws a exception if no argument provided.
 * @memberof wTools
 *
 */

function strToBytes( src )
{

  _.assert( arguments.length === 1, 'expects single argument' );
  _.assert( _.strIs( src ) );

  var result = new Uint8Array( src.length );

  for( var s = 0, sl = src.length ; s < sl ; s++ )
  {
    result[ s ] = src.charCodeAt( s );
  }

  return result;
}

//

/**
 * @name _metrics
 * @type {object}
 * @description Contains metric prefixes.
 * @global
 */

/**
 * Returns string that represents number( src ) with metric unit prefix that depends on options( o ).
 * If no options provided function start calculating metric with default options.
 * Example: for number ( 50000 ) function returns ( "50.0 k" ), where "k"- thousand.
 *
 * @param {(number|string)} src - Source object.
 * @param {object} o - conversion options.
 * @param {number} [ o.divisor=3 ] - Sets count of number divisors.
 * @param {number} [ o.thousand=1000 ] - Sets integer power of one thousand.
 * @param {boolean} [ o.fixed=1 ] - The number of digits to appear after the decimal point, example : [ '58912.001' ].
 * Number must be between 0 and 20.
 * @param {number} [ o.dimensions=1 ] - Sets exponent of a number.
 * @param {number} [ o.metric=0 ] - Sets the metric unit type from the map( _metrics ).
 * @returns {string} Returns number with metric prefix as a string.
 *
 * @example
 * //returns "1.0 M"
 * _.strMetricFormat( 1, { metric : 6 } );
 *
 * @example
 * //returns "100.0 "
 * _.strMetricFormat( "100m", { } );
 *
 * @example
 * //returns "100.0 T
 * _.strMetricFormat( "100m", { metric : 12 } );
 *
 * @example
 * //returns "2 k"
 * _.strMetricFormat( "1500", { fixed : 0 } );
 *
 * @example
 * //returns "1.0 M"
 * _.strMetricFormat( "1000000",{ divisor : 2, thousand : 100 } );
 *
 * @example
 * //returns "10.0 h"
 * _.strMetricFormat( "10000", { divisor : 2, thousand : 10, dimensions : 3 } );
 *
 * @method strMetricFormat
 * @memberof wTools
 *
 */

var _metrics =
{

  '24'  : { name : 'yotta', symbol : 'Y' , word : 'septillion' },
  '21'  : { name : 'zetta', symbol : 'Z' , word : 'sextillion' },
  '18'  : { name : 'exa'  , symbol : 'E' , word : 'quintillion' },
  '15'  : { name : 'peta' , symbol : 'P' , word : 'quadrillion' },
  '12'  : { name : 'tera' , symbol : 'T' , word : 'trillion' },
  '9'   : { name : 'giga' , symbol : 'G' , word : 'billion' },
  '6'   : { name : 'mega' , symbol : 'M' , word : 'million' },
  '3'   : { name : 'kilo' , symbol : 'k' , word : 'thousand' },
  '2'   : { name : 'hecto', symbol : 'h' , word : 'hundred' },
  '1'   : { name : 'deca' , symbol : 'da', word : 'ten' },

  '0'   : { name : ''     , symbol : ''  , word : '' },

  '-1'  : { name : 'deci' , symbol : 'd' , word : 'tenth' },
  '-2'  : { name : 'centi', symbol : 'c' , word : 'hundredth' },
  '-3'  : { name : 'milli', symbol : 'm' , word : 'thousandth' },
  '-6'  : { name : 'micro', symbol : 'μ' , word : 'millionth' },
  '-9'  : { name : 'nano' , symbol : 'n' , word : 'billionth' },
  '-12' : { name : 'pico' , symbol : 'p' , word : 'trillionth' },
  '-15' : { name : 'femto', symbol : 'f' , word : 'quadrillionth' },
  '-18' : { name : 'atto' , symbol : 'a' , word : 'quintillionth' },
  '-21' : { name : 'zepto', symbol : 'z' , word : 'sextillionth' },
  '-24' : { name : 'yocto', symbol : 'y' , word : 'septillionth' },

  range : [ -24,+24 ],

}

function strMetricFormat( number,o )
{

  if( _.strIs( number ) )
  number = parseFloat( number );

  var o = _.routineOptions( strMetricFormat, o );

  _.assert( _.numberIs( number ), '"number" should be Number' );
  _.assert( arguments.length === 1 || arguments.length === 2 );
  _.assert( _.objectIs( o ) || o === undefined,'expects map {-o-}' );
  _.assert( _.numberIs( o.fixed ) );
  _.assert( o.fixed <= 20 );

  var original = number;

  if( o.dimensions !== 1 )
  o.thousand = Math.pow( o.thousand,o.dimensions );

  if( number !== 0 )
  {

    if( Math.abs( number ) > o.thousand )
    {

      while( Math.abs( number ) > o.thousand || !o.metrics[ String( o.metric ) ] )
      {

        if( o.metric + o.divisor > o.metrics.range[ 1 ] ) break;

        number /= o.thousand;
        o.metric += o.divisor;

      }

    }
    else if( Math.abs( number ) < 1 )
    {

      while( Math.abs( number ) < 1 || !o.metrics[ String( o.metric ) ] )
      {

        if( o.metric - o.divisor < o.metrics.range[ 0 ] ) break;

        number *= o.thousand;
        o.metric -= o.divisor;

      }

    }

  }

  var result = '';

  if( o.metrics[ String( o.metric ) ] )
  {
    result = number.toFixed( o.fixed ) + ' ' + o.metrics[ String( o.metric ) ].symbol;
  }
  else
  {
    result = original.toFixed( o.fixed ) + ' ';
  }

  return result;
}

strMetricFormat.defaults =
{
  divisor : 3,
  thousand : 1000,
  fixed : 1,
  dimensions : 1,
  metric : 0,
  metrics : _metrics,
}

//

/**
 * Short-cut for strMetricFormat() function.
 * Converts number( number ) to specific count of bytes with metric prefix.
 * Example: ( 2048 -> 2.0 kb).
 *
 * @param {string|number} str - Source number to  convert.
 * @param {object} o - conversion options.
 * @param {number} [ o.divisor=3 ] - Sets count of number divisors.
 * @param {number} [ o.thousand=1024 ] - Sets integer power of one thousand.
 * @see {@link wTools.strMetricFormat} Check out main function for more usage options and details.
 * @returns {string} Returns number of bytes with metric prefix as a string.
 *
 * @example
 * //returns "100.0 b"
 * _.strMetricFormatBytes( 100 );
 *
 * @example
 * //returns "4.0 kb"
 * _.strMetricFormatBytes( 4096 );
 *
 * @example
 * //returns "1024.0 Mb"
 * _.strMetricFormatBytes( Math.pow( 2, 30 ) );
 *
 * @method strMetricFormatBytes
 * @memberof wTools
 *
 */

function strMetricFormatBytes( number,o )
{

  var o = o || Object.create( null );
  var defaultOptions =
  {
    divisor : 3,
    thousand : 1024,
  };

  _.mapSupplement( o,defaultOptions );

  return _.strMetricFormat( number,o ) + 'b';
}

//

/**
 * Short-cut for strMetricFormat() function.
 * Converts number( number ) to specific count of seconds with metric prefix.
 * Example: ( 1000 (ms) -> 1.000 s).
 *
 * @param {number} str - Source number to  convert.
 * @param {number} [ o.fixed=3 ] - The number of digits to appear after the decimal point, example : [ '58912.001' ].
 * Can`t be changed.
 * @see {@link wTools.strMetricFormat} Check out main function for more usage options and details.
 * @returns {string} Returns number of seconds with metric prefix as a string.
 *
 * @example
 * //returns "1.000 s"
 * _.strTimeFormat( 1000 );
 *
 * @example
 * //returns "10.000 ks"
 * _.strTimeFormat( Math.pow( 10, 7 ) );
 *
 * @example
 * //returns "78.125 s"
 * _.strTimeFormat( Math.pow( 5, 7 ) );
 *
 * @method strTimeFormat
 * @memberof wTools
 *
 */

function strTimeFormat( time )
{
  _.assert( arguments.length === 1 );
  time = _.timeFrom( time );
  var result = _.strMetricFormat( time*0.001,{ fixed : 3 } ) + 's';
  return result;
}

//

function strCsvFrom( src,o )
{

  var result = '';
  var o = o || Object.create( null );

  debugger;

  if( !o.header )
  {

    o.header = [];

    _.look( _.entityValueWithIndex( src,0 ),function( e,k,i )
    {
      o.header.push( k );
    });

  }

  if( o.cellSeparator === undefined ) o.cellSeparator = ',';
  if( o.rowSeparator === undefined ) o.rowSeparator = '\n';
  if( o.substitute === undefined ) o.substitute = '';
  if( o.withHeader === undefined ) o.withHeader = 1;

  //console.log( 'o',o );

  if( o.withHeader )
  {
    _.look( o.header,function( e,k,i ){
      result += e + o.cellSeparator;
    });
    result = result.substr( 0,result.length-o.cellSeparator.length ) + o.rowSeparator;
  }

  _.each( src,function( row )
  {

    var rowString = '';

    _.each( o.header,function( key )
    {

      debugger;
      var element = _.entityWithKeyRecursive( row,key );
      if( element === undefined ) element = '';
      element = String( element );
      if( element.indexOf( o.rowSeparator ) !== -1 )
      element = _.strReplaceAll( element,o.rowSeparator,o.substitute );
      if( element.indexOf( o.cellSeparator ) !== -1 )
      element = _.strReplaceAll( element,o.cellSeparator,o.substitute );

      rowString += element + o.cellSeparator;

    });

    result += rowString.substr( 0,rowString.length-o.cellSeparator.length ) + o.rowSeparator;

  });

  return result;
}

//

function strToDom( xmlStr )
{

  var xmlDoc = null;
  var isIEParser = window.ActiveXObject || "ActiveXObject" in window;

  if( xmlStr === undefined ) return xmlDoc;

  if( window.DOMParser )
  {

    var parser = new window.DOMParser();
    var parsererrorNS = null;

    if( !isIEParser ) {

      try {
        parsererrorNS = parser.parseFromString( "INVALID", "text/xml" ).childNodes[0].namespaceURI;
      }
      catch( err ) {
        parsererrorNS = null;
      }
    }

    try
    {
      xmlDoc = parser.parseFromString( xmlStr, "text/xml" );
      if( parsererrorNS!= null && xmlDoc.getElementsByTagNameNS( parsererrorNS, "parsererror" ).length > 0 )
      {
        throw 'Error parsing XML';
        xmlDoc = null;
      }
    }
    catch( err )
    {
      throw 'Error parsing XML';
      xmlDoc = null;
    }
  }
  else
  {
    if( xmlStr.indexOf( "<?" )==0 )
    {
      xmlStr = xmlStr.substr( xmlStr.indexOf( "?>" ) + 2 );
    }
    xmlDoc = new ActiveXObject( "Microsoft.XMLDOM" );
    xmlDoc.async = "false";
    xmlDoc.loadXML( xmlStr );
  }

  return xmlDoc;
}

//

function strToConfig( src,o )
{
  var result = Object.create( null );
  if( !_.strIs( src ) )
  throw _.err( '_.strToConfig :','require string' );

  var o = o || Object.create( null );
  if( o.delimeter === undefined ) o.delimeter = ' :';

  var src = src.split( '\n' );

  for( var s = 0 ; s < src.length ; s++ )
  {

    var row = src[ s ];
    var i = row.indexOf( o.delimeter );
    if( i === -1 ) continue;

    var key = row.substr( 0,i ).trim();
    var val = row.substr( i+1 ).trim();

    result[ key ] = val;

  }

  return result;
}

//

function strParseMap( o )
{

  if( _.strIs( o ) || _.arrayIs( o ) )
  o = { src : o }

  _.routineOptions( strParseMap,o );
  _.assert( _.strIs( o.entryDelimeter ) );

  var src = o.src;

  if( _.strIs( src ) )
  src = _.strSplit
  ({
    src : src,
    delimeter : o.valKeyDelimeter,
    stripping : 1,
    preservingEmpty : 1,
    preservingDelimeters : 0,
  });

  var result = Object.create( null );
  for( var a = 1 ; a < src.length ; a++ )
  {
    var left = src[ a-1 ];
    var right = src[ a+0 ];
    var val = right;

    if( a < src.length - 1 )
    {
      var cuts = _.strIsolateEndOrAll( right,o.entryDelimeter );
      var val = cuts[ 0 ];
      src[ a+0 ] = cuts[ 2 ];
    }

    if( !isNaN( parseFloat( val ) ) )
    val = parseFloat( val );

    result[ left ] = val;
  }

  return result;
}

strParseMap.defaults =
{
  src : null,
  valKeyDelimeter : ':',
  entryDelimeter : ' ',
}

// --
// strTable
// --

function strTable( o )
{
  _.assert( arguments.length === 1, 'expects single argument' );

  if( !_.objectIs( o ) )
  o = { data : o }
  _.routineOptions( strTable,o );
  _.assert( _.longIs( o.data ) );

  if( typeof module !== 'undefined' && module !== null )
  {
    if( !_.cliTable  )
    try
    {
      _.cliTable = require( 'cli-table2' );
    }
    catch( err )
    {
    }
  }

  if( _.cliTable == undefined )
  {
    if( !o.silent )
    throw _.err( 'version of strTable without support of cli-table2 is not implemented' );
    else
    return;
  }

  /* */

  function makeWidth( propertyName, def, len )
  {
    var property = o[ propertyName ];
    var _property = _.arrayFillTimes( [], len, def );
    if( property )
    {
      _.assert( _.mapIs( property ) || _.longIs( property ) , 'routine expects colWidths/rowWidths property as Object or Array-Like' );
      for( var k in property )
      {
        k = _.numberFrom( k );
        if( k < len )
        {
          _.assert( _.numberIs( property[ k ] ) );
          _property[ k ] = property[ k ];
        }
      }
    }
    o[ propertyName ] = _property;
  }

  //

  var isArrayOfArrays = true;
  var maxLen = 0;
  for( var i = 0; i < o.data.length; i++ )
  {
    if( !_.longIs( o.data[ i ] ) )
    {
      isArrayOfArrays = false;
      break;
    }

    maxLen = Math.max( maxLen, o.data[ i ].length );
  }

  var onCellGet = strTable.onCellGet;
  o.onCellGet = o.onCellGet || isArrayOfArrays ? onCellGet.ofArrayOfArray :  onCellGet.ofFlatArray ;
  o.onCellAfter = o.onCellAfter || strTable.onCellAfter;

  if( isArrayOfArrays )
  {
    o.rowsNumber = o.data.length;
    o.colsNumber = maxLen;
  }
  else
  {
    _.assert( _.numberIs( o.rowsNumber ) && _.numberIs( o.colsNumber ) );
  }

  //

  makeWidth( 'colWidths', o.colWidth, o.colsNumber );
  makeWidth( 'colAligns', o.colAlign, o.colsNumber );
  makeWidth( 'rowWidths', o.rowWidth, o.rowsNumber );
  makeWidth( 'rowAligns', o.rowAlign, o.rowsNumber );

  var tableOptions =
  {
    head : o.head,
    colWidths : o.colWidths,
    rowWidths : o.rowWidths,
    colAligns : o.colAligns,
    rowAligns : o.rowAligns,
    style :
    {
      compact : !!o.compact,
      'padding-left' : o.paddingLeft,
      'padding-right' : o.paddingRight,
    }
  }

  var table = new _.cliTable( tableOptions );

  //

  for( var y = 0; y < o.rowsNumber; y++ )
  {
    var row = [];
    table.push( row );

    for( var x = 0; x < o.colsNumber; x++ )
    {
      var index2d = [ y, x ];
      var cellData = o.onCellGet( o.data, index2d, o );
      var cellStr;

      if( cellData === undefined )
      var cellData = cellStr = '';
      else
      var cellStr = _.toStr( cellData, { wrap : 0, stringWrapper : '' } );

      cellStr = o.onCellAfter( cellStr, index2d, o );
      row.push( cellStr );
    }
  }

  return table.toString();
}

strTable.defaults =
{
  data : null,
  rowsNumber : null,
  colsNumber : null,

  head : null,

  rowWidth : 5,
  rowWidths : null,
  rowAlign : 'center',
  rowAligns : null,

  colWidth : 5,
  colWidths : null,
  colAlign : 'center',
  colAligns : null,

  compact : 1,
  silent : 1,

  paddingLeft : 0,
  paddingRight : 0,


  onCellGet : null,
  onCellAfter : null,
}

strTable.onCellGet =
{
  ofFlatArray : ( data, index2d, o  ) => data[ index2d[ 0 ] * o.colsNumber + index2d[ 1 ] ],
  ofArrayOfArray : ( data, index2d, o  ) => data[ index2d[ 0 ] ][ index2d[ 1 ] ]
}

strTable.onCellAfter = ( cellStr, index2d, o ) => cellStr

//

function strsSort( srcs )
{

  _.assert( _.arrayIs( srcs ) );

  // debugger;

  var result = srcs.sort( function( a, b )
  {
    // a = a.toLowerCase();
    // b = b.toLowerCase();
    if( a < b ) return -1;
    if( a > b ) return +1;
    return 0;
  });

  return result;
}

//

function strDifference( src1,src2,o )
{
  _.assert( _.strIs( src1 ) );
  _.assert( _.strIs( src2 ) );

  if( src1 === src2 )
  return false;

  for( var i = 0, l = Math.min( src1.length, src2.length ) ; i < l ; i++ )
  if( src1[ i ] !== src2[ i ] )
  return src1.substr( 0,i ) + '*';

  return src1.substr( 0,i ) + '*';
}

//

function strSimilarity( src1,src2 )
{
  _.assert( _.strIs( src1 ) );
  _.assert( _.strIs( src2 ) );
  _.assert( arguments.length === 2, 'expects exactly two arguments' );

  debugger;

  var spectres = [ _.strLattersSpectre( src1 ),_.strLattersSpectre( src2 ) ];
  var result = _.strLattersSpectresSimilarity( spectres[ 0 ],spectres[ 1 ] );

  return result;
}

//

function strLattersSpectre( src )
{
  var total = 0;
  var result = new U32x( 257 );

  _.assert( arguments.length === 1 );

  for( var s = 0 ; s < src.length ; s++ )
  {
    var c = src.charCodeAt( s );
    result[ c & 0xff ] += 1;
    total += 1;
    c = c >> 8;
    if( c === 0 )
    continue;
    result[ c & 0xff ] += 1;
    total += 1;
    if( c === 0 )
    continue;
    result[ c & 0xff ] += 1;
    total += 1;
    if( c === 0 )
    continue;
    result[ c & 0xff ] += 1;
    total += 1;
  }

  result[ 256 ] = total;

  return result;
}

//

function strLattersSpectresSimilarity( src1, src2 )
{
  var result = 0;
  var minl = Math.min( src1[ 256 ], src2[ 256 ] );
  var maxl = Math.max( src1[ 256 ], src2[ 256 ] );

  _.assert( arguments.length === 2, 'expects exactly two arguments' );
  _.assert( src1.length === src2.length );

  for( var s = 0 ; s < src1.length-1 ; s++ )
  {
    result += Math.abs( src1[ s ] - src2[ s ] );
  }

  result = ( minl / maxl ) - ( 0.5 * result / maxl );

  if( result > 1 )
  debugger;

  result = _.numberClamp( result, [ 0,1 ] );

  return result;
}

//
//
// function lattersSpectreComparison( src1,src2 )
// {
//
//   var same = 0;
//
//   if( src1.length === 0 && src2.length === 0 ) return 1;
//
//   for( var l in src1 )
//   {
//     if( l === 'length' ) continue;
//     if( src2[ l ] ) same += Math.min( src1[ l ],src2[ l ] );
//   }
//
//   return same / Math.max( src1.length,src2.length );
// }

// --
// define class
// --

var Proto =
{

  strCamelize : strCamelize,
  strFilenameFor : strFilenameFor,
  strVarNameFor : strVarNameFor,
  strHtmlEscape : strHtmlEscape,

  // strToRegexpTolerating : strToRegexpTolerating,
  // strToRegexp : strToRegexp,
  strFind : strFind,

  strSorterParse : strSorterParse,
  strReplaceAll : strReplaceAll, /* document me */

  // format

  strToBytes : strToBytes,
  strMetricFormat : strMetricFormat,
  strMetricFormatBytes : strMetricFormatBytes,

  strTimeFormat : strTimeFormat,

  strCsvFrom : strCsvFrom, /* experimental */
  strToDom : strToDom, /* experimental */
  strToConfig : strToConfig, /* experimental */

  strParseMap : strParseMap,

  strTable : strTable,
  strsSort : strsSort,

  strDifference : strDifference, /* experimental */
  strSimilarity : strSimilarity, /* experimental */
  strLattersSpectre : strLattersSpectre, /* experimental */
  strLattersSpectresSimilarity : strLattersSpectresSimilarity,
  // lattersSpectreComparison : lattersSpectreComparison, /* experimental */

}

_.mapExtend( Self, Proto );

// --
// export
// --

if( typeof module !== 'undefined' )
if( _global_.WTOOLS_PRIVATE )
delete require.cache[ module.id ];

if( typeof module !== 'undefined' && module !== null )
module[ 'exports' ] = Self;

})();
