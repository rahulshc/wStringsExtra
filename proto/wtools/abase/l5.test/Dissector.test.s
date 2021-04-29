( function _Dissector_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  const _ = require( '../../../node_modules/Tools' );
  require( '../l5/Dissector.s' );
  _.include( 'wSelector' );
  _.include( 'wTesting' );
}

const __ = _globals_.testing.wTools;
const _ = _global_.wTools;
const select = __.select;

// --
// dissector
// --

function _codeLex( test )
{

  /* */

  test.case = '^**';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 0, 2 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : 0,
    }
  ]
  var got = _.dissector._codeLex( '^**' );
  test.identical( got, exp );

  /* */

  test.case = 'b<some text 1>**<some text 2>e';
  var exp =
  [
    {
      'type' : 'etc',
      'raw' : 'b',
      'val' : 'b',
      'charInterval' : [ 0, 0 ]
    },
    {
      'type' : 'text',
      'raw' : 'some text 1',
      'val' : 'some text 1',
      'charInterval' : [ 1, 11 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 12, 13 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : 'some text 2',
      'val' : 'some text 2',
      'charInterval' : [ 14, 24 ]
    },
    {
      'type' : 'etc',
      'raw' : 'e',
      'val' : 'e',
      'charInterval' : [ 25, 25 ]
    }
  ]
  var got = _.dissector._codeLex( 'b<some text 1>**<some text 2>e' );
  test.identical( got, exp );

  /* */

  test.case = '  b  < some text 1 > ** < some text 2 >  e  ';
  var exp =
  [
    {
      'type' : 'etc',
      'raw' : ' b',
      'val' : 'b',
      'charInterval' : [ 0, 2 ]
    },
    {
      'type' : 'text',
      'raw' : ' some text 1 ',
      'val' : ' some text 1 ',
      'charInterval' : [ 2, 15 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 15, 17 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : ' some text 2 ',
      'val' : ' some text 2 ',
      'charInterval' : [ 17, 30 ]
    },
    {
      'type' : 'etc',
      'raw' : 'e',
      'val' : 'e',
      'charInterval' : [ 30, 31 ]
    }
  ]
  var got = _.dissector._codeLex( '  b  < some text 1 > ** < some text 2 >  e  ' );
  test.identical( got, exp );

  /* */

  test.case = 'escape left';
  var exp =
  [
    {
      'type' : 'etc',
      'raw' : 'b',
      'val' : 'b',
      'charInterval' : [ 0, 0 ]
    },
    {
      'type' : 'text',
      'raw' : '\\<some\\<text1\\<',
      'val' : '<some<text1<',
      'charInterval' : [ 1, 15 ]
    },
    {
      'type' : 'etc',
      'raw' : 'e',
      'val' : 'e',
      'charInterval' : [ 16, 16 ]
    }
  ]
  var got = _.dissector._codeLex( 'b<\\<some\\<text1\\<>e' );
  test.identical( got, exp );

  /* */

  test.case = 'escape right';
  var exp =
  [
    {
      'type' : 'etc',
      'raw' : 'b',
      'val' : 'b',
      'charInterval' : [ 0, 0 ]
    },
    {
      'type' : 'text',
      'raw' : '\\>some\\>text1\\>',
      'val' : '>some>text1>',
      'charInterval' : [ 1, 15 ]
    },
    {
      'type' : 'etc',
      'raw' : 'e',
      'val' : 'e',
      'charInterval' : [ 16, 16 ]
    }
  ]
  var got = _.dissector._codeLex( 'b<\\>some\\>text1\\>>e' );
  test.identical( got, exp );

  /* */

  test.case = 'escape slash';
  var exp =
  [
    {
      'type' : 'etc',
      'raw' : 'b',
      'val' : 'b',
      'charInterval' : [ 0, 0 ]
    },
    {
      'type' : 'text',
      'raw' : '\\\\some\\\\text1\\\\',
      'val' : '\\some\\text1\\',
      'charInterval' : [ 1, 15 ]
    },
    {
      'type' : 'etc',
      'raw' : 'e',
      'val' : 'e',
      'charInterval' : [ 16, 16 ]
    }
  ]
  var got = _.dissector._codeLex( 'b<\\\\some\\\\text1\\\\>e' );
  test.identical( got, exp );

  /* */

  test.case = 'priority default';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 0, 1 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : 'r1',
      'val' : 'r1',
      'charInterval' : [ 2, 3 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 4, 5 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'text',
      'raw' : 'r2',
      'val' : 'r2',
      'charInterval' : [ 6, 7 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 8, 9 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -2
    }
  ]
  var got = _.dissector._codeLex( `**<r1>**<r2>**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority left higher';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 0, 2 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : -2
    },
    {
      'type' : 'text',
      'raw' : 'r1',
      'val' : 'r1',
      'charInterval' : [ 3, 4 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 5, 6 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : 'r2',
      'val' : 'r2',
      'charInterval' : [ 7, 8 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 9, 10 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    }
  ]
  var got = _.dissector._codeLex( `^**<r1>**<r2>**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority mid higher';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 0, 1 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : 'r1',
      'val' : 'r1',
      'charInterval' : [ 2, 3 ]
    },
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 4, 6 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : -2
    },
    {
      'type' : 'text',
      'raw' : 'r2',
      'val' : 'r2',
      'charInterval' : [ 7, 8 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 9, 10 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    }
  ]
  var got = _.dissector._codeLex( `**<r1>^**<r2>**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority right higher';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 0, 1 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : 'r1',
      'val' : 'r1',
      'charInterval' : [ 2, 3 ]
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 4, 5 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'text',
      'raw' : 'r2',
      'val' : 'r2',
      'charInterval' : [ 6, 7 ]
    },
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 8, 10 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : -2
    }
  ]
  var got = _.dissector._codeLex( `**<r1>**<r2>^**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority all';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 0, 2 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'text',
      'raw' : 'r1',
      'val' : 'r1',
      'charInterval' : [ 3, 4 ]
    },
    {
      'type' : 'any',
      'raw' : '^^^**',
      'val' : '^^^**',
      'charInterval' : [ 5, 9 ],
      'map' : { 'priority' : '^^^', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'text',
      'raw' : 'r2',
      'val' : 'r2',
      'charInterval' : [ 10, 11 ]
    },
    {
      'type' : 'any',
      'raw' : '^^^^^**',
      'val' : '^^^^^**',
      'charInterval' : [ 12, 18 ],
      'map' : { 'priority' : '^^^^^', 'any' : '**' },
      'priority' : -2
    }
  ]
  var got = _.dissector._codeLex( `^**<r1>^^^**<r2>^^^^^**` );
  test.identical( got, exp );

  /* */

  test.case = 'text';
  var exp =
  [
    {
      'type' : 'text',
      'raw' : 'r1',
      'val' : 'r1',
      'charInterval' : [ 0, 1 ]
    },
    {
      'type' : 'text',
      'raw' : 'r2',
      'val' : 'r2',
      'charInterval' : [ 2, 3 ]
    }
  ]
  var got = _.dissector._codeLex( `<r1><r2>` );
  test.identical( got, exp );

  /* */

  test.case = 'many any without spaces';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 0, 1 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 2, 3 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 4, 5 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -2
    }
  ]
  var got = _.dissector._codeLex( `******` );
  test.identical( got, exp );

  /* */

  test.case = 'many any with spaces';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 0, 2 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 2, 4 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 4, 6 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -2
    }
  ]
  var got = _.dissector._codeLex( `**  ** ** ` );
  test.identical( got, exp );

  /* */

  test.case = 'many any with priorities';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : '^^**',
      'val' : '^^**',
      'charInterval' : [ 0, 3 ],
      'map' : { 'priority' : '^^', 'any' : '**' },
      'priority' : -2
    },
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 4, 6 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 7, 8 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  var got = _.dissector._codeLex( `^^**^****` );
  test.identical( got, exp );

  /* */

  test.case = 'many any with priorities and spaces';
  var exp =
  [
    {
      'type' : 'any',
      'raw' : ' ^^**',
      'val' : '^^**',
      'charInterval' : [ 0, 5 ],
      'map' : { 'priority' : '^^', 'any' : '**' },
      'priority' : -2
    },
    {
      'type' : 'any',
      'raw' : '^**',
      'val' : '^**',
      'charInterval' : [ 5, 8 ],
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'any',
      'raw' : '**',
      'val' : '**',
      'charInterval' : [ 8, 10 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  var got = _.dissector._codeLex( ` ^^ ** ^ **  **  ` );
  test.identical( got, exp );

  /* */

}

//

function make( test )
{

  /* */

  test.case = 'basic';
  var code = '**<r1>**<r2>**';
  var dissector = _.dissector.make( code );

  test.description = 'tokenSteps';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '**',
      'raw' : '**',
      'charInterval' : [ 0, 1 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0,
    },
    {
      'type' : 'text',
      'val' : 'r1',
      'raw' : 'r1',
      'charInterval' : [ 2, 3 ],
    },
    {
      'type' : 'any',
      'val' : '**',
      'raw' : '**',
      'charInterval' : [ 4, 5 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -1
    },
    {
      'type' : 'text',
      'val' : 'r2',
      'raw' : 'r2',
      'charInterval' : [ 6, 7 ],
    },
    {
      'type' : 'any',
      'val' : '**',
      'raw' : '**',
      'charInterval' : [ 8, 9 ],
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : -2
    }
  ]
  test.identical( dissector.tokenSteps, exp );

  test.description = 'parcelSteps';
  var exp =
  [
    {
      'side' : 'left',
      'map' :
      {
        'any' : dissector.tokenSteps[ 0 ],
        'first' : dissector.tokenSteps[ 1 ],
      },
      'priority' : 0,
      'type' : 'first',
      'tokenSteps' :
      [
        dissector.tokenSteps[ 0 ],
        dissector.tokenSteps[ 1 ],
      ],
      'eat' : dissector.eatMap.firstLeft,
      'tinterval' : [ 0, 1 ],
      'sensetiveInterval' : [ 0, 1 ],
      'index' : 1,
    },
    {
      'side' : 'left',
      'map' :
      {
        'any' : dissector.tokenSteps[ 2 ],
        'first' : dissector.tokenSteps[ 3 ],
      },
      'priority' : -1,
      'type' : 'first',
      'tokenSteps' :
      [
        dissector.tokenSteps[ 2 ],
        dissector.tokenSteps[ 3 ],
      ],
      'eat' : dissector.eatMap.firstLeft,
      'tinterval' : [ 2, 3 ],
      'sensetiveInterval' : [ 2, 3 ],
      'index' : 2,
    },
    {
      'side' : 'left',
      'map' :
      {
        'any' : dissector.tokenSteps[ 4 ],
      },
      'priority' : _.dissector._maxPriority + 10,
      'type' : 'rest',
      'tokenSteps' : [ dissector.tokenSteps[ 4 ] ],
      'eat' : dissector.eatMap.restLeft,
      'tinterval' : [ 4, 4 ],
      'sensetiveInterval' : [ 4, 4 ],
      'index' : 3,
    }
  ]
  test.identical( dissector.parcelSteps, exp );

  test.description = 'static';
  test.true( _.mapIs( dissector.eatMap ) );
  test.true( _.routineIs( dissector.parse ) );

  delete dissector.tokenSteps
  delete dissector.rightSteps
  delete dissector.leftSteps
  delete dissector.parcelSteps
  delete dissector.eatMap;
  delete dissector.parse;

  var exp = { code };
  test.identical( dissector, exp );

  /* */

}

//

function dissectBasic( test )
{

  /* */

  test.case = 'basic';
  var text = 'a r1 b r1 c r2 d r2 e';
  var dissection = _.dissector.dissect( `**<r1>**<r2>**`, text );

  test.description = '*/val';
  var exp = [ 'a r1', ' b r1 c r2', ' d r2 e' ];
  var got = _.select( dissection.parcels, '*/val' );
  test.identical( got, exp );

  test.description = '*/pstep/type';
  var exp = [ 'first', 'first', 'rest' ];
  var got = _.select( dissection.parcels, '*/pstep/type' );
  test.identical( got, exp );

  test.description = '*/pstep/side';
  var exp = [ 'left', 'left', 'left' ];
  var got = _.select( dissection.parcels, '*/pstep/side' );
  test.identical( got, exp );

  test.description = 'export';
  var exp = '**<r1>^**<r2>^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1 first.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
  });

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'map';
  var exp = {};
  test.identical( dissection.map, exp );

  test.description = 'matched';
  var exp = true;
  test.identical( dissection.matched, exp );

  test.description = 'parcels.length';
  var exp = 3;
  test.identical( dissection.parcels.length, 3 );

  test.description = 'parcels[ 0 ]';
  test.true( dissection.parcels[ 0 ].pstep !== dissection.parcels[ 0 ].tstep );
  test.true( _.object.isBasic( dissection.parcels[ 0 ].pstep ) );
  delete dissection.parcels[ 0 ].pstep;
  test.true( _.nullIs( dissection.parcels[ 0 ].tstep ) );
  delete dissection.parcels[ 0 ].tstep;
  test.true( dissection.parcels[ 0 ].tokens.length === 2 );
  delete dissection.parcels[ 0 ].tokens;
  test.identical( _.props.keys( dissection.parcels[ 0 ].map ), [ 'any', 'first' ] );
  delete dissection.parcels[ 0 ].map;
  var exp =
  {
    val : 'a r1',
    interval : [ 0, 3 ],
  };
  test.identical( dissection.parcels[ 0 ], exp );
  console.log( __.entity.exportJs( dissection.parcels[ 0 ] ) );

  test.description = 'parcels[ 1 ]';
  test.true( dissection.parcels[ 1 ].pstep !== dissection.parcels[ 1 ].tstep );
  test.true( _.object.isBasic( dissection.parcels[ 1 ].pstep ) );
  delete dissection.parcels[ 1 ].pstep;
  test.true( _.nullIs( dissection.parcels[ 1 ].tstep ) );
  delete dissection.parcels[ 1 ].tstep;
  test.true( dissection.parcels[ 1 ].tokens.length === 2 );
  delete dissection.parcels[ 1 ].tokens;
  test.identical( _.props.keys( dissection.parcels[ 1 ].map ), [ 'any', 'first' ] );
  delete dissection.parcels[ 1 ].map;
  var exp =
  {
    val : ' b r1 c r2',
    interval : [ 4, 13 ],
  };
  test.identical( dissection.parcels[ 1 ], exp );
  console.log( __.entity.exportJs( dissection.parcels[ 1 ] ) );

  test.description = 'parcels[ 2 ]';
  test.true( dissection.parcels[ 2 ].pstep !== dissection.parcels[ 2 ].tstep );
  test.true( _.object.isBasic( dissection.parcels[ 2 ].pstep ) );
  delete dissection.parcels[ 2 ].pstep;
  test.true( _.object.isBasic( dissection.parcels[ 2 ].tstep ) );
  delete dissection.parcels[ 2 ].tstep;
  test.true( _.arrayIs( dissection.parcels[ 2 ].tokens ) );
  delete dissection.parcels[ 2 ].tokens;
  test.identical( _.props.keys( dissection.parcels[ 2 ].map ), [] );
  delete dissection.parcels[ 2 ].map;
  var exp =
  {
    val : ' d r2 e',
    interval : [ 14, 20 ],
  };
  test.identical( dissection.parcels[ 2 ], exp );
  console.log( __.entity.exportJs( dissection.parcels[ 2 ] ) );

  /* */

}

//

function dissectAny( test )
{

  /* */

  test.case = `<r1>**<r2> -- r1abcr2`;
  var text = 'r1abcr2';
  var code = `<r1>**<r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '<r1>**<r2>';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1 rest.left#3 text.right#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1', 'abc', 'r2' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1', 'abc', 'r2' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `<r1>**<r2> -- rabcr2`;
  var text = 'rabcr2';
  var code = `<r1>**<r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '<r1>**<r2>';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = '';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, '' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `<r1>**<r2> -- r1abcr`;
  var text = 'r1abcr';
  var code = `<r1>**<r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '<r1>**<r2>';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, 'r1' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, 'r1' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `**<r1>**<r2>** -- a r1 b r1 c r2 d r2 e`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `**<r1>**<r2>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '**<r1>^**<r2>^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1 first.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'a r1', ' b r1 c r2', ' d r2 e' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'a ', 'r1', ' b r1 c ', 'r2', ' d r2 e' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**<r1>^**<r2>^^** -- a r1 b r1 c r2 d r2 e`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `**<r1>^**<r2>^^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '**<r1>^**<r2>^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1 first.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'a r1', ' b r1 c r2', ' d r2 e' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'a ', 'r1', ' b r1 c ', 'r2', ' d r2 e' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**<r1>^^**<r2>^^^^** -- a r1 b r1 c r2 d r2 e`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `**<r1>^^**<r2>^^^^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '**<r1>^**<r2>^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1 first.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'a r1', ' b r1 c r2', ' d r2 e' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'a ', 'r1', ' b r1 c ', 'r2', ' d r2 e' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^^**<r1>^**<r2>** -- a r1 b r1 c r2 d r2 e`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `^^**<r1>^**<r2>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '^^**<r1>^**<r2>**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'rest.left#3 first.right#2 first.right#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'a r1 b ', 'r1 c r2 d ', 'r2 e' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'a r1 b ', 'r1', ' c r2 d ', 'r2', ' e' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `****** -- abcde`;
  var text = 'abcde';
  var code = `******`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '**^**^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left#1 least.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', '', 'abcde' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', '', 'abcde' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**^^**^^^** -- abcde`;
  var text = 'abcde';
  var code = `**^^**^^^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '**^**^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left#1 least.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', '', 'abcde' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', '', 'abcde' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^^**^**** -- abcde`;
  var text = 'abcde';
  var code = `^^**^****`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `^^**^****`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'rest.left#3 least.right#2 least.right#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'abcde', '', '' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'abcde', '', '' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^** ** ^** -- abcde`;
  var text = 'abcde';
  var code = `^** ** ^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `^****^^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left#1 least.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', '', 'abcde' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', '', 'abcde' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^** ** ^** -- ""`;
  var text = '';
  var code = `^** ** ^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `^****^^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left#1 least.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', '', '' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', '', '' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  /*
    default   0  -1  -2
    current   0  -2  -1
  */

  test.case = `** ^** ** -- abcde`;
  var text = 'abcde';
  var code = `** ^** **`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**^^**^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left#1 rest.left#3 least.right#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', 'abcde', '' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', 'abcde', '' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `** ^** ** -- ""`;
  var text = '';
  var code = `** ^** **`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**^^**^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left#1 rest.left#3 least.right#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', '', '' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', '', '' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `** <a> ^** <a> ** -- 0a1a2a3a4`;
  var text = '0a1a2a3a4';
  var code = `** <a> ^** <a> **`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**<a>^^**<a>^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1 rest.left#3 first.right#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '0a', '1a2a3', 'a4' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '0', 'a', '1a2a3', 'a', '4' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `** <a> ^** <a> ** -- 0a1b2b3b4`;
  var text = '0a1b2b3b4';
  var code = `** <a> ^** <a> **`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**<a>^^**<a>^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '0a' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '0', 'a' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, '0a' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, '0a' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `^** <a> ** <a> ^** -- 0a1a2a3a4`;
  var text = '0a1a2a3a4';
  var code = `^** <a> ** <a> ^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `^**<a>**<a>^^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1 first.left#2 rest.left#3';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '0a', '1a', '2a3a4' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '0', 'a', '1', 'a', '2a3a4' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^** <a> ** <a> ^** -- 0a1b2b3b4`;
  var text = '0a1b2b3b4';
  var code = `^** <a> ** <a> ^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `^**<a>**<a>^^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '0a' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '0', 'a' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, '0a' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, '0a' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

}

//

function dissectText( test )
{

  /* */

  test.case = `<r1><r2> -- r1r2`;
  var text = 'r1r2';
  var code = `<r1><r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1><r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1 text.left#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1', 'r2' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1', 'r2' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `<r1><r2> -- ""`;
  var text = 'r1';
  var code = `<r1><r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1><r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `<r1><r2> -- "r1"`;
  var text = 'r1';
  var code = `<r1><r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1><r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `<r1><r2> -- "r2"`;
  var text = 'r2';
  var code = `<r1><r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1><r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = '';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, '' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `<r1>** -- r1r2`;
  var text = 'r1r2';
  var code = `<r1>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1>**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1 rest.left#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1', 'r2' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1', 'r2' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `<r1>** -- r1`;
  var text = 'r1';
  var code = `<r1>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1>**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'text.left#1 rest.left#2';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1', '' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1', '' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `<r1>** -- r`;
  var text = 'r';
  var code = `<r1>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `<r1>**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = '';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, '' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

  test.case = `**<r2> -- r1r2`;
  var text = 'r1r2';
  var code = `**<r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**<r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'rest.left#2 text.right#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ 'r1', 'r2' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ 'r1', 'r2' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**<r2> -- r2`;
  var text = 'r2';
  var code = `**<r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**<r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'rest.left#2 text.right#1';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [ '', 'r2' ];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [ '', 'r2' ];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**<r2> -- x`;
  var text = 'x';
  var code = `**<r2>`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**<r2>`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = '';
  var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  test.identical( got, exp );

  test.description = 'parcels/*/val';
  var exp = [];
  var got = _.select( dissection, 'parcels/*/val' );
  test.identical( got, exp );

  test.description = 'tokens/*/val';
  var exp = [];
  var got = _.select( dissection, 'tokens/*/val' );
  test.identical( got, exp );

  test.description = 'parcels/*/interval';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.interval ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/interval';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.interval ) );
    text2 += token.val;
  });
  test.identical( text2, '' );

  test.description = 'matched';
  test.identical( dissection.matched, false );

  /* */

}

// --
//
// --

const Proto =
{

  name : 'Tools.Dissector',
  silencing : 1,

  tests :
  {

    _codeLex,
    make,
    dissectBasic,
    dissectAny,
    dissectText,

  }

}

const Self = wTestSuite( Proto );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
