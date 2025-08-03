# simple_loading

A highly customizable and simple Flutter package to display elegant loading indicators and spinners, with support for Lottie animations and standard Flutter widgets.

## 🚀 Installation

Add this to your `pubspec.yaml`:

```yaml
dependencies:
  simple_loading: <latest_version>
```

Then run:

```bash
flutter pub get
```

## 📦 Import

```dart
import 'package:simple_loading/simple_loading.dart';
```

## 💡 Usage Example

### Basic Lottie Loading

The default loader is a Lottie animation. It will automatically dismiss after the specified time.

```dart
ElevatedButton(
  onPressed: () {
    SimpleLoading.show(context, seconds: 3);
  },
  child: const Text('Show Lottie for 3s'),
)
```

### Customizing Loaders

You can choose from various loading types and customize their properties.

```dart
// Show a red circular loader with a custom stroke width
ElevatedButton(
  onPressed: () {
    SimpleLoading.show(
      context,
      loadingType: Type.circular,
      indicatorColor: Colors.red,
      strokeWidth: 8.0,
    );
    Future.delayed(const Duration(seconds: 3), () => SimpleLoading.close());
  },
  child: const Text('Show Circular Loader'),
)

// Show a linear loader with a custom color and background
ElevatedButton(
  onPressed: () {
    SimpleLoading.show(
      context,
      loadingType: Type.linear,
      indicatorColor: Colors.blue,
      indicatorBackgroundColor: Colors.yellow.withOpacity(0.5),
    );
    Future.delayed(const Duration(seconds: 3), () => SimpleLoading.close());
  },
  child: const Text('Show Linear Loader'),
)

// Show a Cupertino-style loader
ElevatedButton(
  onPressed: () {
    SimpleLoading.show(context, loadingType: Type.cupertino);
    Future.delayed(const Duration(seconds: 3), () => SimpleLoading.close());
  },
  child: const Text('Show Cupertino Loader'),
)
```

## 🛠 Customization Options

You can customize the loader using the following parameters in `SimpleLoading.show()`:

* `loadingType`: The type of loading indicator (`Type.lottie`, `Type.circular`, etc.)
* `lottiePath`: Custom path for a Lottie animation
* `size`: Size of the loading container
* `backgroundColor`: Background color of the loading container
* `borderRadius`: Roundness of the container corners
* `seconds`: Auto-dismiss the loader after this many seconds
* `indicatorColor`: Color of the `circular`, `linear`, or `cupertino` indicators
* `indicatorBackgroundColor`: Background color for `LinearProgressIndicator`
* `strokeWidth`: Thickness of the `circular` indicator's stroke

## 🔌 Supported Loading Types

The package includes a built-in `Type` enum for easy selection:

```dart
Type.lottie
Type.circular
Type.linear
Type.cupertino
Type.refresh
```

## 📂 Example with Custom Lottie Animation

### 📂 Add Assets

Make sure to include your custom Lottie asset in `pubspec.yaml`:

```yaml
flutter:
  assets:
    - assets/lottie/your_custom_animation.json
```

### 💡 Usage

Then, provide the custom path when calling `SimpleLoading.show()`:

```dart
SimpleLoading.show(
  context,
  lottiePath: 'assets/lottie/your_custom_animation.json',
);
