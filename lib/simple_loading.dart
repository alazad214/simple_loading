// Required for using Timer functionality
import 'dart:async';
// Imports the animation path from your package
// Imports Cupertino widgets for iOS-style indicators
import 'package:flutter/cupertino.dart';
// Imports Material Design widgets
import 'package:flutter/material.dart';
// Imports the Lottie package for animations
import 'package:lottie/lottie.dart';
import 'package:simple_loading/src/animation_path.dart';

// Defines an enum for the different types of loading indicators
enum Type {
  lottie,
  circular,
  linear,
  cupertino,
  refresh,
}

// The main class for the SimpleLoading package
class SimpleLoading {
  // A static variable to hold the OverlayEntry, which is the loading screen itself
  static OverlayEntry? _overlayEntry;
  // A static Timer to automatically close the loader after a set duration
  static Timer? _autoCloseTimer;

  // The main method to show the loading overlay
  static void show(
    BuildContext context, {
    // Defines the type of loading indicator to show, defaults to Lottie
    Type loadingType = Type.lottie,
    // Optional path for a custom Lottie animation file
    String? lottiePath,
    // Optional size for the loading indicator container
    double? size,
    // Background color of the loading container, defaults to transparent
    Color backgroundColor = Colors.transparent,
    // Border radius of the loading container, defaults to 8
    double borderRadius = 8,
    // Optional duration in seconds to automatically close the loader
    int? seconds,
    // Optional color for the loading indicator (e.g., for CircularProgressIndicator)
    Color? indicatorColor,
    // Optional background color for the indicator (e.g., for LinearProgressIndicator)
    Color? indicatorBackgroundColor,
    // Optional stroke width for circular indicators
    double? strokeWidth,
  }) {
    // Prevents showing multiple loaders at the same time
    if (_overlayEntry != null) return;

    // Gets the screen width for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    // Calculates the loader size based on the screen width if not provided
    final loaderSize = size ?? screenWidth / 1.5;

    // Creates the OverlayEntry with the loading widget
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            // A semi-transparent black background to dim the screen
            Positioned.fill(
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
            // Centers the loading indicator container
            Center(
              child: Container(
                // Container decoration with background color and border radius
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                // Padding around the loading indicator
                padding: const EdgeInsets.all(16),
                // Sets the size of the loading indicator child
                child: SizedBox(
                  height: loaderSize,
                  width: loaderSize,
                  // Builds the actual loading content based on the type
                  child: _buildLoaderContent(
                    loadingType,
                    lottiePath,
                    indicatorColor,
                    indicatorBackgroundColor,
                    strokeWidth,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // Inserts the created overlay into the Flutter widget tree
    Overlay.of(context).insert(_overlayEntry!);

    // If 'seconds' is provided, starts a timer to automatically close the loader
    if (seconds != null) {
      _autoCloseTimer?.cancel();
      _autoCloseTimer = Timer(Duration(seconds: seconds), () {
        close();
      });
    }
  }

  // A static method to manually close/dismiss the loader
  static void close() {
    // Cancels the auto-close timer if it exists
    _autoCloseTimer?.cancel();
    _autoCloseTimer = null;

    // Removes the overlay from the widget tree and resets the variable
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // A private method to build the specific loading widget based on the selected type
  static Widget _buildLoaderContent(
    Type loadingType,
    String? lottiePath,
    Color? indicatorColor,
    Color? indicatorBackgroundColor,
    double? strokeWidth,
  ) {
    // Uses a switch statement to return the correct widget for each Type
    switch (loadingType) {
      case Type.circular:
        return Center(
          child: CircularProgressIndicator(
            // Uses the provided color or a default if none is given
            color: indicatorColor ?? Colors.blue,
            // Uses the provided stroke width or a default if none is given
            strokeWidth: strokeWidth ?? 5.0,
          ),
        );
      case Type.linear:
        return Center(
          child: LinearProgressIndicator(
            // Uses the provided color or a default if none is given
            color: indicatorColor ?? Colors.cyanAccent,
            // Uses the provided background color or a default
            backgroundColor: indicatorBackgroundColor,
            // A border radius for the linear indicator
            borderRadius: BorderRadius.circular(10),
          ),
        );
      case Type.cupertino:
        return Center(
          child: CupertinoActivityIndicator(
            // Uses the provided color or a default
            color: indicatorColor ?? Colors.blue,
            // Sets a fixed radius for the Cupertino indicator
            radius: 20,
          ),
        );
      case Type.refresh:
        return Center(
          child: RefreshProgressIndicator(
            // Uses the provided color or a default
            color: indicatorColor ?? Colors.blue,
          ),
        );
      case Type.lottie:
      default:
        // Returns the Lottie animation
        return Lottie.asset(
          // Uses the provided Lottie path or a default
          lottiePath ?? AnimationPath.lottie,
          fit: BoxFit.contain,
          repeat: true,
        );
    }
  }
}
