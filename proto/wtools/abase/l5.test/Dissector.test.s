( function _Dissector_test_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../wtools/Tools.s' );
  require( '../l5/Dissector.s' );
  _.include( 'wSelector' );
  _.include( 'wTesting' );
}

let select = _globals_.testing.wTools.select;
let _ = _global_.wTools;

// --
// dissector
// --

function _codeLex( test )
{

  /* */

  test.case = 'basic';
  var exp =
  [
    'b',
    { 'type' : 'text', 'val' : 'some text 1' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    { 'type' : 'text', 'val' : 'some text 2' },
    'e',
  ]
  var got = _.dissector._codeLex( 'b<some text 1>**<some text 2>e' );
  test.identical( got, exp );

  /* */

  test.case = 'extra spaces';
  var exp =
  [
    'b',
    { 'type' : 'text', 'val' : ' some text 1 ' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    { 'type' : 'text', 'val' : ' some text 2 ' },
    'e'
  ]
  var got = _.dissector._codeLex( '  b  < some text 1 > ** < some text 2 >  e  ' );
  test.identical( got, exp );

  /* */

  test.case = 'escape left';
  var exp =
  [
    'b',
    { 'type' : 'text', 'val' : '<some<text1<' },
    'e'
  ]
  var got = _.dissector._codeLex( 'b<\\<some\\<text1\\<>e' );
  test.identical( got, exp );

  /* */

  test.case = 'escape right';
  var exp =
  [
    'b',
    { 'type' : 'text', 'val' : '>some>text1>' },
    'e'
  ]
  var got = _.dissector._codeLex( 'b<\\>some\\>text1\\>>e' );
  test.identical( got, exp );

  /* */

  test.case = 'escape slash';
  var exp =
  [
    'b',
    { 'type' : 'text', 'val' : '\\some\\text1\\' },
    'e'
  ]
  var got = _.dissector._codeLex( 'b<\\\\some\\\\text1\\\\>e' );
  test.identical( got, exp );

  /* */

  test.case = 'priority default';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 2
    },
    { 'type' : 'text', 'val' : 'r1' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 1
    },
    { 'type' : 'text', 'val' : 'r2' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  var got = _.dissector._codeLex( `**<r1>**<r2>**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority left lowered';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '^**',
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : 2
    },
    { 'type' : 'text', 'val' : 'r1' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 1
    },
    { 'type' : 'text', 'val' : 'r2' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  var got = _.dissector._codeLex( `^**<r1>**<r2>**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority mid lowered';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 1
    },
    { 'type' : 'text', 'val' : 'r1' },
    {
      'type' : 'any',
      'val' : '^**',
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : 2
    },
    { 'type' : 'text', 'val' : 'r2' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  var got = _.dissector._codeLex( `**<r1>^**<r2>**` );
  test.identical( got, exp );

  /* */

  test.case = 'priority right lowered';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 1
    },
    { 'type' : 'text', 'val' : 'r1' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    },
    { 'type' : 'text', 'val' : 'r2' },
    {
      'type' : 'any',
      'val' : '^**',
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : 2
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
      'val' : '^**',
      'map' : { 'priority' : '^', 'any' : '**' },
      'priority' : 0
    },
    { 'type' : 'text', 'val' : 'r1' },
    {
      'type' : 'any',
      'val' : '^^^**',
      'map' : { 'priority' : '^^^', 'any' : '**' },
      'priority' : 1
    },
    { 'type' : 'text', 'val' : 'r2' },
    {
      'type' : 'any',
      'val' : '^^^^^**',
      'map' : { 'priority' : '^^^^^', 'any' : '**' },
      'priority' : 2
    }
  ]
  var got = _.dissector._codeLex( `^**<r1>^^^**<r2>^^^^^**` );
  test.identical( got, exp );

  /* */

  test.case = 'text';
  var exp =
  [
    { 'type' : 'text', 'val' : 'r1' },
    { 'type' : 'text', 'val' : 'r2' },
  ]
  var got = _.dissector._codeLex( `<r1><r2>` );
  test.identical( got, exp );

  /* */

  test.case = 'many any';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 2
    },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 1
    },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  var got = _.dissector._codeLex( `******` );
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

  test.description = 'tsteps';
  var exp =
  [
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 2
    },
    { 'type' : 'text', 'val' : 'r1' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 1
    },
    { 'type' : 'text', 'val' : 'r2' },
    {
      'type' : 'any',
      'val' : '**',
      'map' : { 'priority' : '', 'any' : '**' },
      'priority' : 0
    }
  ]
  test.identical( dissector.tsteps, exp );

  test.description = 'lsteps';
  var exp =
  [
    {
      'side' : 'left',
      'map' :
      {
        'any' : dissector.tsteps[ 0 ],
        'first' : dissector.tsteps[ 1 ],
      },
      'priority' : 2,
      'type' : 'first',
      'tsteps' :
      [
        dissector.tsteps[ 0 ],
        dissector.tsteps[ 1 ],
      ],
      'eat' : dissector.eatMap.firstLeft,
      'trange' : [ 0, 1 ]
    },
    {
      'side' : 'left',
      'map' :
      {
        'any' : dissector.tsteps[ 2 ],
        'first' : dissector.tsteps[ 3 ],
      },
      'priority' : 1,
      'type' : 'first',
      'tsteps' :
      [
        dissector.tsteps[ 2 ],
        dissector.tsteps[ 3 ],
      ],
      'eat' : dissector.eatMap.firstLeft,
      'trange' : [ 2, 3 ]
    },
    {
      'side' : 'left',
      'map' :
      {
        'any' : dissector.tsteps[ 4 ],
      },
      'priority' : _.dissector._maxPriority + 10,
      'type' : 'rest',
      'tsteps' :
      [
        dissector.tsteps[ 4 ],
      ],
      'eat' : dissector.eatMap.restLeft,
      'trange' : [ 4, 4 ]
    }
  ]
  test.identical( dissector.lsteps, exp );

  test.description = 'rsteps';
  var exp =
  [
    {
      'side' : 'right',
      'map' :
      {
        'any' : dissector.tsteps[ 0 ],
      },
      'priority' : _.dissector._maxPriority + 10,
      'type' : 'rest',
      'tsteps' :
      [
        dissector.tsteps[ 0 ],
      ],
      'eat' : dissector.eatMap.restRight,
      'trange' : [ 0, 0 ]
    },
    {
      'side' : 'right',
      'map' :
      {
        'any' : dissector.tsteps[ 2 ],
        'first' : dissector.tsteps[ 1 ],
      },
      'priority' : 1,
      'type' : 'first',
      'tsteps' :
      [
        dissector.tsteps[ 2 ],
        dissector.tsteps[ 1 ],
      ],
      'eat' : dissector.eatMap.firstRight,
      'trange' : [ 1, 2 ]
    },
    {
      'side' : 'right',
      'map' :
      {
        'any' : dissector.tsteps[ 4 ],
        'first' : dissector.tsteps[ 3 ],
      },
      'priority' : 0,
      'type' : 'first',
      'tsteps' :
      [
        dissector.tsteps[ 4 ],
        dissector.tsteps[ 3 ],
      ],
      'eat' : dissector.eatMap.firstRight,
      'trange' : [ 3, 4 ]
    }
  ]
  test.identical( dissector.rsteps, exp );

  test.description = 'static';
  test.is( _.mapIs( dissector.eatMap ) );
  test.is( _.routineIs( dissector.parse ) );

  delete dissector.tsteps
  delete dissector.rsteps
  delete dissector.lsteps
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

  test.description = 'parcels/*/range';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
  });

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  test.is( dissection.parcels[ 0 ].pstep !== dissection.parcels[ 0 ].tstep );
  test.is( _.objectIs( dissection.parcels[ 0 ].pstep ) );
  delete dissection.parcels[ 0 ].pstep;
  test.is( _.nullIs( dissection.parcels[ 0 ].tstep ) );
  delete dissection.parcels[ 0 ].tstep;
  test.is( dissection.parcels[ 0 ].tokens.length === 2 );
  delete dissection.parcels[ 0 ].tokens;
  test.identical( _.mapKeys( dissection.parcels[ 0 ].map ), [ 'any', 'first' ] );
  delete dissection.parcels[ 0 ].map;
  var exp =
  {
    val : 'a r1',
    range : [ 0, 3 ],
  };
  test.identical( dissection.parcels[ 0 ], exp );
  console.log( _globals_.testing.wTools.toJs( dissection.parcels[ 0 ] ) );

  test.description = 'parcels[ 1 ]';
  test.is( dissection.parcels[ 1 ].pstep !== dissection.parcels[ 1 ].tstep );
  test.is( _.objectIs( dissection.parcels[ 1 ].pstep ) );
  delete dissection.parcels[ 1 ].pstep;
  test.is( _.nullIs( dissection.parcels[ 1 ].tstep ) );
  delete dissection.parcels[ 1 ].tstep;
  test.is( dissection.parcels[ 1 ].tokens.length === 2 );
  delete dissection.parcels[ 1 ].tokens;
  test.identical( _.mapKeys( dissection.parcels[ 1 ].map ), [ 'any', 'first' ] );
  delete dissection.parcels[ 1 ].map;
  var exp =
  {
    val : ' b r1 c r2',
    range : [ 4, 13 ],
  };
  test.identical( dissection.parcels[ 1 ], exp );
  console.log( _globals_.testing.wTools.toJs( dissection.parcels[ 1 ] ) );

  test.description = 'parcels[ 2 ]';
  test.is( dissection.parcels[ 2 ].pstep !== dissection.parcels[ 2 ].tstep );
  test.is( _.objectIs( dissection.parcels[ 2 ].pstep ) );
  delete dissection.parcels[ 2 ].pstep;
  test.is( _.objectIs( dissection.parcels[ 2 ].tstep ) );
  delete dissection.parcels[ 2 ].tstep;
  test.is( _.arrayIs( dissection.parcels[ 2 ].tokens ) );
  delete dissection.parcels[ 2 ].tokens;
  test.identical( _.mapKeys( dissection.parcels[ 2 ].map ), [] );
  delete dissection.parcels[ 2 ].map;
  var exp =
  {
    val : ' d r2 e',
    range : [ 14, 20 ],
  };
  test.identical( dissection.parcels[ 2 ], exp );
  console.log( _globals_.testing.wTools.toJs( dissection.parcels[ 2 ] ) );

  /* */

}

//

function dissectAny( test )
{

  /* */

  test.case = `**<r1>**<r2>**`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `**<r1>**<r2>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '^^**<r1>^**<r2>**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left first.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^^**<r1>^**<r2>**`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `^^**<r1>^**<r2>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '^^**<r1>^**<r2>**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left first.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^^^^**<r1>^^**<r2>**`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `^^^^**<r1>^^**<r2>**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '^^**<r1>^**<r2>**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'first.left first.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**<r1>^**<r2>^^**`;
  var text = 'a r1 b r1 c r2 d r2 e';
  var code = `**<r1>^**<r2>^^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '**<r1>^**<r2>^^**';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'rest.right first.right first.right';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text ); debugger;

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `****** -- abcde`;
  var text = 'abcde';
  var code = `******`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '^^**^****';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left least.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `^^^**^^**** -- abcde`;
  var text = 'abcde';
  var code = `^^^**^^****`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = '^^**^****';
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'least.left least.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  test.case = `**^**^^** -- abcde`;
  var text = 'abcde';
  var code = `**^**^^**`;
  var dissection = _.dissector.dissect( code, text );

  test.description = 'export';
  var exp = `**^**^^**`;
  var got = _.dissector.dissectorExportToString( dissection.dissector );
  test.identical( got, exp );

  test.description = 'track';
  var exp = 'rest.right least.right least.right';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
    text2 += token.val;
  });
  test.identical( text2, text );

  test.description = 'matched';
  test.identical( dissection.matched, true );

  /* */

  // test.case = `^** ** ^** -- abcde`;
  // var text = 'abcde';
  // var code = `^** ** ^**`;
  // var dissection = _.dissector.dissect( code, text );
  //
  // test.description = 'export';
  // var exp = `^^****^**`;
  // var got = _.dissector.dissectorExportToString( dissection.dissector );
  // test.identical( got, exp );
  //
  // test.description = 'track';
  // var exp = 'least.left rest.left least.right';
  // var got = _.dissector.dissectionExportToString({ src : dissection, mode : 'track' });
  // test.identical( got, exp );
  //
  // test.description = 'parcels/*/val';
  // var exp = [ 'abcde', '', '' ];
  // var got = _.select( dissection, 'parcels/*/val' );
  // test.identical( got, exp );
  //
  // test.description = 'tokens/*/val';
  // var exp = [ 'abcde', '', '' ];
  // var got = _.select( dissection, 'tokens/*/val' );
  // test.identical( got, exp );
  //
  // test.description = 'parcels/*/range';
  // var text2 = '';
  // dissection.parcels.forEach( ( parcel ) =>
  // {
  //   test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
  //   test.identical( parcel.val, _.strOnly( text, parcel.range ) );
  //   text2 += parcel.val;
  // });
  // test.identical( text2, text );
  //
  // test.description = 'tokens/*/range';
  // var text2 = '';
  // dissection.tokens.forEach( ( token ) =>
  // {
  //   test.description = `${token.tstep.type}`;
  //   test.identical( token.val, _.strOnly( text, token.range ) );
  //   text2 += token.val;
  // });
  // test.identical( text2, text );
  //
  // test.description = 'matched';
  // test.identical( dissection.matched, true );

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
  var exp = 'text.left text.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  var exp = 'text.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  var exp = 'text.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  var exp = 'text.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  var exp = 'text.left rest.left';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  var exp = 'rest.right text.right';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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
  var exp = 'rest.right text.right';
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, text );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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

  test.description = 'parcels/*/range';
  var text2 = '';
  dissection.parcels.forEach( ( parcel ) =>
  {
    test.description = `${parcel.pstep.type}.${parcel.pstep.side}`;
    test.identical( parcel.val, _.strOnly( text, parcel.range ) );
    text2 += parcel.val;
  });
  test.identical( text2, '' );

  test.description = 'tokens/*/range';
  var text2 = '';
  dissection.tokens.forEach( ( token ) =>
  {
    test.description = `${token.tstep.type}`;
    test.identical( token.val, _.strOnly( text, token.range ) );
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

let Self =
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

Self = wTestSuite( Self );
if( typeof module !== 'undefined' && !module.parent )
wTester.test( Self.name );

})();
