
if( typeof module !== 'undefined' )
require( 'wstringsextra' );
fs = require('fs');
let _ = wTools;

/**/
// var env  = {};
// env.njs10 = '**Njs : v10.24.1**';
// env.njs12= 'Kos : Njs : v12.9.1';
// env.njs14='**Njs : v14.17.0**';
// env.njs15 = '**Njs : v15.14.0**';
// env.is= 'is';
// env.isUsingGetPrototype = 'isUsingGetPrototype';
// env.isUsingGetPrototypeWithFunctor = 'isUsingGetPrototypeWithFunctor';
// env.isUsingExistenceOfField = 'isUsingExistenceOfField';
// env.isUsingSet = 'isUsingSet';
// env.isUsingHashMap = 'isUsingHashMap';
// env.isUsingMap = 'isUsingMap';
// env.isSlow= 'isSlow';
// env.blank=' ';

// var dim = [ 3, 7 ];
// var data =
// [
//   '0.530', '4.250', '0.685', '0.700', '1.432', '4.266', '4.215',
//   '0.603', '6.347', '0.671', '0.675', '1.418', '5.597', '5.573',
//   '0.562', '6.437', '0.627', '0.584', '1.318', '5.572', '5.558',
// ];
// var style = 'doubleBorder';
// var rowSplits = 1;
// var colSplits = 1;
// var topHead =
// [
//   env.blank, env.is, env.isSlow, env.isUsingGetPrototype, env.isUsingGetPrototypeWithFunctor, env.isUsingExistenceOfField,
//   env.isUsingSet, env.isUsingHashMap, env.isUsingMap
// ];
// var bottomHead = [ env.njs12, env.blank, env.blank, env.blank, env.blank, env.blank, env.blank, env.blank, env.blank ];
// var leftHead = [ env.blank, env.njs10, env.njs14, env.njs15, env.njs12 ];
// var rightHead = [ env.isUsingMap, '3.414', '4.682', '4.520', env.blank ];
// var got = _.strTable( { data, dim, style, topHead, bottomHead, leftHead, rightHead, rowSplits, colSplits } );
// console.log( got.result );
// fs.writeFile( 'a.txt', got.result, function ( err )
// {
//   if( err )
//   return console.log( err );
//   console.log( 'Done' );
// });

var env  = {};
env.njs10 = '**Njs : v10.24.1**';
env.njs12= 'Kos : Njs : v12.9.1';
env.njs14='**Njs : v14.17.0**';
env.njs15 = '**Njs : v15.14.0**';
env.is= 'anyIs';
env.isCompact= 'bufferAnyIsAlternative';
env.blank='';

var dim = [ 3, 1 ];
var data =
[
  '8.575',
  '',
  ''
];
var style = 'doubleBorder';
var rowSplits = 1;
var colSplits = 1;
var topHead =
[
  env.blank, env.is, env.isCompact
];
var bottomHead = [ env.njs12, env.blank, env.blank ];
var leftHead = [ env.blank, env.njs10, env.njs14, env.njs15, env.njs12 ];
var rightHead = [ env.isCompact, '7.643', '', '', env.blank ];
var got = _.strTable( { data, dim, style, topHead, bottomHead, leftHead, rightHead, rowSplits, colSplits } );
console.log( got.result );
fs.writeFile( 'a.txt', got.result, function ( err )
{
  if( err )
  return console.log( err );
  console.log( 'Done' );
});

/*
Some test 13 14 this is 13 x
*/
