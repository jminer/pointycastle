// Copyright (c) 2013-present, the authors of the Pointy Castle project
// This library is dually licensed under LGPL 3 and MPL 2.0.
// See file LICENSE for more information.

library pointycastle.test.test.padding_tests;

import "dart:typed_data";

import "package:test/test.dart";
import "package:pointycastle/pointycastle.dart";

import "./src/helpers.dart";

void runPaddingTest( Padding pad, CipherParameters params,
                     String unpadData, int padLength, String padData ) {

  group( "${pad.algorithmName}:", () {

    test( "addPadding: $unpadData", () {

      var expectedBytes = createUint8ListFromHexString( padData );
      var dataBytes = new Uint8List( padLength )
        ..setAll( 0, unpadData.codeUnits )
      ;

      pad.init( params );
      var ret = pad.addPadding( dataBytes, unpadData.length );

      expect( ret, equals( padLength-unpadData.length ) );
      expect( dataBytes, equals(expectedBytes) );

    });

    test( "padCount: $padData", () {

      var dataBytes = createUint8ListFromHexString( padData );

      pad.init( params );
      var ret = pad.padCount( dataBytes );

      expect( ret, equals( padLength-unpadData.length ) );

    });

  });

}

