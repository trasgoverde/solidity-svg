// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title SVG
/// @notice Generate SVG shapes like rect, circle, line and polygon or a custom one.
/// @author naomsa <https://twitter.com/naomsa666>
library SVG {
  /* solhint-disable quotes */

  /* -------------------------------------------------------------------------- */
  /*                                Shapes Logic                                */
  /* -------------------------------------------------------------------------- */

  /* --------------------------------- <rect> --------------------------------- */

  /// @notice Generate a <rect> element.
  /// @param x Rectangle x position.
  /// @param y Rectangle y position.
  /// @param width Rectangle width.
  /// @param height Rectangle height.
  /// @param attrs Other rectangle attributes.
  /// @param values Other rectangle values by attribute.
  function rect(
    string memory x,
    string memory y,
    string memory width,
    string memory height,
    string[] memory attrs,
    string[] memory values
  ) internal pure returns (string memory) {
    require(attrs.length == values.length, "SVG::rect: attributes and values length mismatch");

    attrs[attrs.length] = "x";
    values[values.length] = x;

    attrs[attrs.length] = "y";
    values[values.length] = y;

    attrs[attrs.length] = "width";
    values[values.length] = width;

    attrs[attrs.length] = "height";
    values[values.length] = height;

    return element("rect", attrs, values);
  }

  /// @notice Generate a <rect> element without extra attributes.
  /// @param x Rectangle x position.
  /// @param y Rectangle y position.
  /// @param width Rectangle width.
  /// @param height Rectangle height.
  function rect(
    string memory x,
    string memory y,
    string memory width,
    string memory height
  ) internal pure returns (string memory) {
    string[] memory attrs;
    string[] memory values;

    // just overload
    return rect(x, y, width, height, attrs, values);
  }

  /* -------------------------------- <circle> -------------------------------- */

  /// @notice Generate a <circle> element.
  /// @param x Circle x position.
  /// @param y Circle y position.
  /// @param r Circle radius.
  /// @param attrs Other circle attributes.
  /// @param values Other circle values by attribute.
  function circle(
    string memory x,
    string memory y,
    string memory r,
    string[] memory attrs,
    string[] memory values
  ) internal pure returns (string memory) {
    require(attrs.length == values.length, "SVG::circle: attributes and values length mismatch");

    attrs[attrs.length] = "x";
    values[values.length] = x;

    attrs[attrs.length] = "y";
    values[values.length] = y;

    attrs[attrs.length] = "r";
    values[values.length] = r;

    return element("circle", attrs, values);
  }

  /// @notice Generate a <circle> element without extra attributes.
  /// @param x Circle x position.
  /// @param y Circle y position.
  /// @param r Circle radius.
  function circle(
    string memory x,
    string memory y,
    string memory r
  ) internal pure returns (string memory) {
    string[] memory attrs;
    string[] memory values;

    // just overload
    return circle(x, y, r, attrs, values);
  }

  /* --------------------------------- <line> --------------------------------- */

  /// @notice Generate a <line> element.
  /// @param x1 Line x1 position.
  /// @param y1 Line y1 position.
  /// @param x2 Line x2 position.
  /// @param y2 Line y2 position.
  /// @param attrs Other line attributes.
  /// @param values Other line values by attribute.
  function line(
    string memory x1,
    string memory y1,
    string memory x2,
    string memory y2,
    string[] memory attrs,
    string[] memory values
  ) internal pure returns (string memory) {
    require(attrs.length == values.length, "SVG::line: attributes and values length mismatch");

    attrs[attrs.length] = "x1";
    values[values.length] = x1;

    attrs[attrs.length] = "y1";
    values[values.length] = y1;

    attrs[attrs.length] = "x2";
    values[values.length] = x2;

    attrs[attrs.length] = "y2";
    values[values.length] = y2;

    return element("line", attrs, values);
  }

  /// @notice Generate a <line> element without extra attributes.
  /// @param x1 Line x1 position.
  /// @param y1 Line y1 position.
  /// @param x2 Line x2 position.
  /// @param y2 Line y2 position.
  function line(
    string memory x1,
    string memory y1,
    string memory x2,
    string memory y2
  ) internal pure returns (string memory) {
    string[] memory attrs;
    string[] memory values;

    // just overload
    return line(x1, y1, x2, y2, attrs, values);
  }

  /* -------------------------------- <polygon> ------------------------------- */

  /// @notice Generate a <polygon> element.
  /// @param points Polygon points.
  /// @param attrs Other polygon attributes.
  /// @param values Other polygon values by attribute.
  function polygon(
    string memory points,
    string[] memory attrs,
    string[] memory values
  ) internal pure returns (string memory) {
    require(attrs.length == values.length, "SVG::polygon: attributes and values length mismatch");

    // set polygon points
    attrs[attrs.length] = "points";
    values[values.length] = points;

    return element("polygon", attrs, values);
  }

  /// @notice Generate a <polygon> element without extra attributes.
  /// @param points Polygon points.
  function polygon(string memory points) internal pure returns (string memory) {
    string[] memory attrs;
    string[] memory values;

    // just overload
    return polygon(points, attrs, values);
  }

  /* --------------------------------- <path> --------------------------------- */

  /// @notice Generate a <path> element.
  /// @param d Path d attribute.
  /// @param attrs Other path attributes.
  /// @param values Other path values by attribute.
  function path(
    string memory d,
    string[] memory attrs,
    string[] memory values
  ) internal pure returns (string memory) {
    require(attrs.length == values.length, "SVG::path: attributes and values length mismatch");

    // set element d attribute
    attrs[attrs.length] = "d";
    values[values.length] = d;

    // generate path
    return element("path", attrs, values);
  }

  /// @notice Generate a <path> element without extra attributes.
  /// @param d Path d attribute.
  function path(string memory d) internal pure returns (string memory) {
    string[] memory attrs;
    string[] memory values;

    // just overload
    return path(d, attrs, values);
  }

  /* ----------------------------------- <?> ---------------------------------- */

  /// @notice Generate a custom element.
  /// @param el Element name.
  /// @param attrs Element attributes.
  /// @param values Element values by attribute.
  function element(
    string memory el,
    string[] memory attrs,
    string[] memory values
  ) internal pure returns (string memory) {
    require(attrs.length == values.length, "SVG::path: attributes and values length mismatch");

    // initialize element tag
    string memory output = string(string.concat("<", bytes(el), " "));

    // append each attribute and value
    for (uint256 i = 0; i < attrs.length; i++) {
      output = string(string.concat(bytes(output), bytes(attrs[i]), '="', bytes(values[i]), '" '));
    }

    // close element tag
    return string(string.concat(bytes(output), "/>"));
  }
}
