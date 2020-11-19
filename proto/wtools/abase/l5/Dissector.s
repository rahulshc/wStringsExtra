(function _Dissector_s_()
{

'use strict';

if( typeof module !== 'undefined' )
{
  let _ = require( '../../../wtools/Tools.s' );
  _.include( 'wArraySorted' );
  _.include( 'wArraySparse' );
  _.include( 'wBlueprint' );
}

//

let _ = _global_.wTools;
let Self = _.dissector = _.dissector || Object.create( null );

// --
// dissector
// --

function dissectionIs( src )
{
  if( !_.objectIs( src ) )
  return false;
  if( !_.objectIs( src.dissector ) || !_.arrayIs( src.parcels ) )
  return false;
  return true;
}

//

function dissectorIs( src )
{
  if( !_.objectIs( src ) )
  return false;
  if( !_.strIs( src.code ) || !_.routineIs( src.parse ) )
  return false;
  return true;
}

//

function _codeLex_head( routine, args )
{

  let o = args[ 0 ]
  if( !_.mapIs( o ) )
  {
    o =
    {
      code : args[ 0 ],
    }
  }

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  _.routineOptions( routine, o );

  return o;
}

function _codeLex_body( o )
{

  let op = Object.create( null );
  let delimeter = [ '\\\\', '\\<', '\\>', '<', '>', ' ', '**', '*' ];

  op.splits = _.strSplit
  ({
    src : o.code,
    delimeter,
    stripping : 0,
    preservingDelimeters : 1,
    preservingEmpty : 0,
  });

  _.strSplitsQuotedRejoin.body
  ({
    splits : op.splits,
    delimeter,
    quoting : 1,
    quotingPrefixes : [ '<' ],
    quotingPostfixes : [ '>' ],
    preservingQuoting : 0,
    inliningQuoting : 0,
    onQuoting,
  });

  _.strSplitsStrip.body
  ({
    splits : op.splits,
    stripping : 1,
  });

  _.strSplitsDropEmpty.body
  ({
    splits : op.splits,
  })

  priorityRejoin();

  splitsUnescape( op.splits );

  prioritize1( op.splits );

  reprioritize( op.splits );

  return op.splits;

  function priorityRejoin()
  {

    for( let i = 0 ; i < op.splits.length ; i++ )
    {
      let split = op.splits[ i ];
      if( !_.strIs( split ) )
      continue;
      if( !/^\^+$/.test( split ) )
      continue;
      debugger;
      _.assert( op.splits[ i + 1 ] === '**', 'Cant tokenize template' );
      op.splits[ i + 1 ] = split + op.splits[ i + 1 ];
      op.splits.splice( i, 1 );
    }

  }

  function prioritize1( splits )
  {
    for( let s = 0 ; s < splits.length ; s++ )
    {
      let split = splits[ s ];
      if( !_.strIs( split ) )
      continue;
      let parsed = /(\^*)(\*\*)/.exec( split );
      if( !parsed )
      continue;
      let tstep = Object.create( null );
      tstep.type = 'any';
      tstep.val = split;
      tstep.map = Object.create( null );
      tstep.map.priority = parsed[ 1 ];
      tstep.map.any = parsed[ 2 ];
      tstep.priority = parsed[ 1 ].length;
      splits[ s ] = tstep;
    }
  }

  function reprioritize( splits )
  {

    let min = +Infinity;
    let max = -Infinity;
    let indexToPriority = Object.create( null );
    let priorities = [];

    for( let s = 0 ; s < splits.length ; s++ )
    {
      let split = splits[ s ];
      if( _.strIs( split ) )
      continue;
      if( split.priority !== undefined )
      {
        if( min > split.priority )
        min = split.priority;
        if( max < split.priority )
        max = split.priority;
        indexToPriority[ s ] = split.priority;
        sortedAdd( priorities, { priority : split.priority, index : s } );
      }
    }

    let effectivePriority = 0;
    for( let p = 0 ; p < priorities.length ; p++ )
    {
      let current = priorities[ p ];
      splits[ current.index ].priority = effectivePriority;
      effectivePriority += 1;
      _.assert( -_.dissector._maxPriority <= effectivePriority && effectivePriority <= _.dissector._maxPriority );
      if( Config.debug )
      {
        if( p > 0 && priorities[ p-1 ].priority === priorities[ p ].priority )
        _.assert( priorities[ p-1 ].index > priorities[ p ].index );
      }
    }

  }

  function sortedAdd( array, ins )
  {
    return _.sorted.addLeft( array, ins, ( e ) => e.priority );
  }

  function splitsUnescape( splits )
  {
    for( let s = 0 ; s < splits.length ; s++ )
    {
      let split = splits[ s ];
      if( !_.mapIs( split ) || split.type !== 'text' )
      continue;
      let map =
      {
        '\\<' : '<',
        '\\>' : '>',
        '\\\\' : '\\',
      }
      split.val = _.strReplaceAll( split.val, map );
    }
  }

  function onQuoting( e, op )
  {
    let tstep = Object.create( null );
    tstep.type = 'text';
    tstep.val = e;
    return tstep;
  }
}

_codeLex_body.defaults =
{
  code : null
}

let _codeLex = _.routineUnite( _codeLex_head, _codeLex_body );

//

function make_head( routine, args )
{

  let o = args[ 0 ]
  if( !_.mapIs( o ) )
  {
    o =
    {
      code : args[ 0 ],
    }
  }

  _.assert( args.length === 1 );
  _.assert( arguments.length === 2 );
  _.routineOptions( routine, o );

  return o;
}

function make_body( o )
{

  let dissector = Object.create( null );
  dissector.code = o.code;
  dissector.tsteps = _.dissector._codeLex.body( o );
  dissector.eatMap = eatMapGenerate();
  dissector.lsteps = stepsLeftGenerate();
  dissector.rsteps = stepsRightGenerate();
  dissector.parse = parse;

  /* steps range */
  let lstep = 0;
  let rstep = dissector.rsteps.length - 1;

  /* token steps range */
  let ltstep = 0;
  let rtstep = dissector.tsteps.length - 1;

  /* input text range */
  let ltext;
  let rtext;

  /* markers */
  let pmarker = 0;
  let tmarker = 0;

  /* etc */
  let pstep, direct, text;

  return dissector;

  /* - */

  function parse( _text )
  {
    let result = Object.create( null );
    result.dissector = dissector;
    result.parcels = [];
    result.tokens = [];
    result.map = Object.create( null );
    result.matched = null;

    text = _text;
    ltext = 0;
    rtext = text.length-1;

    _.assert( arguments.length === 1 );
    _.assert( _.strIs( _text ) );

    while( ltstep <= rtstep )
    {
      direct = dissector.lsteps[ lstep ].priority >= dissector.rsteps[ rstep ].priority;
      pstep = direct ? dissector.lsteps[ lstep ] : dissector.rsteps[ rstep ];

      if( Config.debug )
      {
        /* xxx : use _.range.in* */
        _.assert
        (
          ltstep <= pstep.trange[ 0 ] && pstep.trange[ 1 ] <= rtstep
          , `Current pstep is ${_.dissector._stepExportToStringShort( pstep )}`
          , `\nPstep has token interval ${pstep.trange[ 0 ]} .. ${pstep.trange[ 1 ]}.`
          , `\nBut current token interval is ${ltstep} .. ${rtstep}`
        );
      }

      let parcel = pstep.eat();

      if( !parcel )
      {
        result.matched = false;
        return result;
      }

      parcelNormalize( parcel );

      if( direct )
      {
        result.parcels.splice( pmarker, 0, parcel );
        pmarker += 1;
        result.tokens.splice( tmarker, 0, ... parcel.tokens );
        tmarker += parcel.tokens.length;
        ltstep += pstep.tsteps.length;
        lstep += 1;
        ltext = parcel.range[ 1 ] + 1;
      }
      else
      {
        result.parcels.splice( pmarker, 0, parcel );
        result.tokens.splice( tmarker, 0, ... [ ... parcel.tokens ].reverse() );
        rtstep -= pstep.tsteps.length;
        rstep -= 1;
        rtext = parcel.range[ 0 ] - 1;
      }
    }

    if( result.matched === null )
    {
      result.matched = ltstep > rtstep;
      _.assert( !result.matched || ltext > rtext );
    }

    return result;
  }

  /* */

  function parcelNormalize( parcel )
  {
    if( parcel.tokens === undefined )
    {
      parcel.tokens = [ parcel ];
    }
    if( parcel.pstep === undefined )
    parcel.pstep = pstep;
    if( parcel.tstep === undefined )
    {
      _.assert( !!pstep.tsteps );
      _.assert( pstep.tsteps.length === 1 );
      parcel.tstep = pstep.tsteps[ 0 ];
    }
    _.assert( _.range.is( parcel.range ) );
    _.assert( _.mapIs( parcel.map ) );
  }

  /* */

  function eatFirstLeft()
  {
    let left = _.strLeft( text, pstep.map.first.val, [ ltext, rtext+1 ] );
    if( left.index === -1 )
    return;

    let any = Object.create( null );
    any.range = [ ltext, left.index-1 ];
    any.val = text.slice( ltext, left.index );
    any.tstep = pstep.map.any;
    any.pstep = null;

    let first = Object.create( null );
    first.range = [ left.index, left.index+pstep.map.first.val.length-1 ];
    first.val = pstep.map.first.val;
    first.tstep = pstep.map.first;
    first.pstep = null;

    let parcel = Object.create( null );
    parcel.range ; [ ltext, left.index+pstep.map.first.val.length-1 ];
    parcel.val = text.slice( ltext, left.index+pstep.map.first.val.length );
    parcel.tokens = [ any, first ];
    parcel.range = [ ltext, left.index+pstep.map.first.val.length-1 ];
    parcel.tstep = null;
    parcel.pstep = pstep;
    parcel.map =
    {
      any,
      first,
    }

    return parcel;
  }

  /* */

  function eatFirstRight()
  {
    let right = _.strRight( text, pstep.map.first.val, [ ltext, rtext+1 ] );
    if( right.index === -1 )
    return;

    let any = Object.create( null );
    any.range = [ right.index+pstep.map.first.val.length, rtext ];
    any.val = text.slice( right.index+pstep.map.first.val.length, rtext+1 );
    any.tstep = pstep.map.any;
    any.pstep = null;

    let first = Object.create( null );
    first.range = [ right.index, right.index+pstep.map.first.val.length-1 ];
    first.val = pstep.map.first.val;
    first.tstep = pstep.map.first;
    first.pstep = null;

    let parcel = Object.create( null );
    parcel.range = [ right.index, rtext ];
    parcel.val = text.slice( right.index, rtext+1 );
    parcel.tokens = [ any, first ];
    parcel.range = [ right.index, rtext ];
    parcel.tstep = null;
    parcel.pstep = pstep;
    parcel.map =
    {
      any,
      first,
    }

    return parcel;
  }

  /* */

  function eatRestLeft()
  {
    let parcel =
    {
      range : [ ltext, text.length-1 ],
      val : text.slice( ltext ),
      map : Object.create( null ),
    };
    return parcel;
  }

  /* */

  function eatRestRight()
  {
    let parcel =
    {
      range : [ 0, rtext ],
      val : text.slice( o, rtext+1 ),
      map : Object.create( null ),
    };
    return parcel;
  }

  /* */

  function eatLeastLeft()
  {
    let parcel =
    {
      range : [ ltext, ltext-1 ],
      val : '',
      map : Object.create( null ),
    };
    return parcel;
  }

  /* */

  function eatLeastRight()
  {
    let parcel =
    {
      range : [ rtext+1, rtext ],
      val : '',
      map : Object.create( null ),
    };
    return parcel;
  }

  /* */

  function eatTextLeft()
  {
    let match = pstep.val === text.slice( ltext, ltext + pstep.val.length );
    if( !match )
    return;
    let parcel =
    {
      range : [ ltext, ltext + pstep.val.length - 1 ],
      val : pstep.val,
      map : Object.create( null ),
    };
    return parcel;
  }

  /* */

  function eatTextRight()
  {
    debugger;
    let match = pstep.val === text.slice( rtext - pstep.val.length + 1, rtext + 1 );
    if( !match )
    return;
    let parcel =
    {
      range : [ rtext - pstep.val.length + 1, rtext ],
      val : pstep.val,
      map : Object.create( null ),
    };
    return parcel;
  }

  /* */

  function eatMapGenerate()
  {
    let eatMap = Object.create( null );
    eatMap.restLeft = eatRestLeft;
    eatMap.restRight = eatRestRight;
    eatMap.firstLeft = eatFirstLeft;
    eatMap.firstRight = eatFirstRight;
    eatMap.leastLeft = eatLeastLeft;
    eatMap.leastRight = eatLeastRight;
    eatMap.textLeft = eatTextLeft;
    eatMap.textRight = eatTextRight;
    return eatMap;
  }

  /* */

  function stepsLeftGenerate()
  {
    let lsteps = [];
    let op = Object.create( null );
    op.dissector = dissector;
    op.tindex = 0;
    op.direct = true;
    while( op.tindex < dissector.tsteps.length )
    {
      op.tindex2 = op.tindex + 1;
      let pstep = _.dissector._stepGenerate( op );
      lsteps.push( pstep );
      op.tindex += pstep.tsteps.length;
    }
    return lsteps;
  }

  /* */

  function stepsRightGenerate()
  {
    let rsteps = [];
    let op = Object.create( null );
    op.dissector = dissector;
    op.tindex = dissector.tsteps.length-1;
    op.direct = false;
    while( op.tindex >= 0 )
    {
      op.tindex2 = op.tindex - 1;
      let pstep = _.dissector._stepGenerate( op );
      rsteps.unshift( pstep );
      op.tindex -= pstep.tsteps.length;
    }
    return rsteps;
  }

  /* */

}

make_body.defaults =
{
  code : null
}

let make = _.routineUnite( make_head, make_body );

//

function _stepGenerate( op )
{
  let pstep;

  op.tstep = op.dissector.tsteps[ op.tindex ];
  op.tstep2 = op.dissector.tsteps[ op.tindex2 ];

  _.assert
  (
      _.objectIs( op.tstep ) && _.longHas( [ 'any', 'text' ], op.tstep.type )
    , `Unknown type of token of the shape ${op.dissector.code}`
  );

  if( op.tstep.type === 'any' )
  {
    pstep = Object.create( null );
    pstep.map = Object.create( null );
    pstep.map.any = op.tstep;
    pstep.priority = op.tstep.priority;
    if( op.tstep2 === undefined )
    {
      pstep.type = 'rest';
      pstep.priority = _.dissector._maxPriority + 10;
      pstep.tsteps = [ op.tstep ];
    }
    else if( op.tstep2.type === 'text' )
    {
      pstep.type = 'first';
      pstep.map.first = op.tstep2;
      pstep.tsteps = [ op.tstep, op.tstep2 ];
    }
    else if( op.tstep2.type === 'any' )
    {
      pstep.type = 'least';
      pstep.map.least = op.tstep2;
      pstep.tsteps = [ op.tstep ];
    }
    else _.assert( 0, 'Unexpected' );
  }
  else if( op.tstep.type === 'text' )
  {
    pstep = Object.create( null );
    pstep.tsteps = [ op.tstep ];
    pstep.type = op.tstep.type;
    pstep.val = op.tstep.val;
    pstep.priority = _.dissector._maxPriority + 20;
    _.assert( op.tstep.side === undefined );
    _.assert( op.tstep.priority === undefined );
  }
  else _.assert( 0 );

  if( pstep.side === undefined )
  pstep.side = ( op.direct ? 'left' : 'right' );

  _.assert( pstep.eat === undefined );
  let rname = pstep.type + ( op.direct ? 'Left' : 'Right' );
  pstep.eat = op.dissector.eatMap[ rname ];
  _.assert( _.routineIs( pstep.eat ), `No such eater ${rname}` );

  _.assert( pstep.trange === undefined );
  if( op.direct )
  pstep.trange = [ op.tindex, op.tindex + pstep.tsteps.length - 1 ];
  else
  pstep.trange = [ op.tindex - pstep.tsteps.length + 1, op.tindex ];

  _.assert( _.numberIs( pstep.priority ) );
  _.assert( _.arrayIs( pstep.tsteps ) );

  return pstep;
}

_stepGenerate.defaults =
{
  dissector : null,
  tindex : null,
  direct : null,
  tindex2 : null,
  tindex : null,
}

//

function dissect_head( routine, args )
{

  let o = args[ 0 ]
  if( !_.mapIs( o ) )
  {
    o =
    {
      code : args[ 0 ],
      text : args[ 1 ],
    }
  }

  _.assert( args.length === 1 || args.length === 2 );
  _.assert( arguments.length === 2 );
  _.routineOptions( routine, o );

  return o;
}

function dissect_body( o )
{
  let dissector = _.dissector.make.body( o );
  return dissector.parse( o.text );
}

dissect_body.defaults =
{
  text : null,
  code : null,
}

let dissect = _.routineUnite( dissect_head, dissect_body );

//

function _tstepExportToString( tstep )
{

  if( tstep.type === 'any' )
  {
    _.assert( tstep.priority >= 0 );
    return _.strDup( '^', tstep.priority ) + tstep.map.any;
  }
  else if( tstep.type === 'text' )
  {
    _.assert( tstep.priority === 0 || tstep.priority === undefined );
    return `<${tstep.val}>`;
  }
  else _.assert( 0 );

}

//

function dissectorExportToString( dissector )
{
  let result = '';

  _.assert( _.dissector.dissectorIs( dissector ) );

  dissector.tsteps.forEach( ( tstep ) =>
  {
    result += _.dissector._tstepExportToString( tstep );
  });

  return result;
}

//

function _stepExportToStringShort( step )
{
  return `${step.type}.${step.side}`;
}

//

function dissectionExportToString( o )
{
  let result = '';

  _.routineOptions( dissectionExportToString, arguments );
  _.assert( _.dissector.dissectionIs( o.src ) );
  _.assert( _.longHas( [ 'track' ], o.mode ) );

  if( o.mode === 'track' )
  {
    o.src.parcels.forEach( ( parcel ) =>
    {
      let s = _.dissector._stepExportToStringShort( parcel.pstep );
      if( result.length )
      result += ` ${s}`;
      else
      result += `${s}`;
    });
    return result;
  }
  else _.assert( 0 );

}

dissectionExportToString.defaults =
{
  src : null,
  mode : 'track',
}

//

/* zzz : imlement parsing with template routine _.dissector.dissect()

  b ^** ':' ** e
  b ^** ':' ^** ':' ** e
  b ^*+ s+ ^^*+ ':' *+ e
  b ( ^*+ )^ <&( s+ )&> ( ^^*+ ':' *+ )^ e

b subject:^** s+ map:** e
// 'c:/dir1 debug:0' -> subject : 'c:/dir1', debug:0

// test.identical( _.strCount( op.output, /program.end(.|\n|\r)*timeout1/mg ), 1 );
test.identical( _.strCount( op.output, `'program.end'**'timeout1'` ), 1 );

*/

// --
// declare
// --

let DissectorExtension =
{

  dissectionIs,
  dissectorIs,
  is : dissectorIs,

  _codeLex,
  make,
  _stepGenerate,
  dissect,

  _tstepExportToString,
  dissectorExportToString,
  _stepExportToStringShort,
  dissectionExportToString,

  _maxPriority : 1 << 20,

}

_.mapExtend( _.dissector, DissectorExtension );

// --
// export
// --

if( typeof module !== 'undefined' )
module[ 'exports' ] = Self;

})();
