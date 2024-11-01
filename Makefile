ifeq (build-appbundle,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

ifeq (build-ios,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

ifeq (module,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

ifeq (module-b,$(firstword $(MAKECMDGOALS)))
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY=help

help:  ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

###
# Run section
###
clean: ## Clean our project build tmp files
	fvm flutter clean && fvm flutter pub get
run: ## Run any app with flavor name. e.g. make run base
	fvm flutter run
xcode: ## Open xcode project
	open -a Xcode.app ios/
git-force: ## Force git push
	git add .
	git commit --amend --no-edit
	git push -f
device: ## Open device on computer
	scrcpy
active-adb: ## Active adm mode in device
	adb tcpip 5555
run-ios: ## Open xcode from build run
	open ios/Runner.xcworkspace


###
# Build section
###
install-slidy: ## Instal slidy
	fvm dart pub global activate slidy
module: ## Create new module
	slidy generate module modules/${RUN_ARGS} --complete
module-b: ## Create new module
	slidy generate module modules/${RUN_ARGS}
mobx: ## BuildRunner mobx
	fvm dart run build_runner build --delete-conflicting-outputs 
build-apk: ## Build an APK of any app with flavor name. e.g. make build base
	fvm flutter clean && fvm flutter pub get && fvm flutter build apk --release
build-appbundle: ## Build an APK of any app with flavor name. e.g. make build base
	fvm flutter build appbundle --release
build-ios: ## Build an APK of any app with flavor name. e.g. make build base
	fvm flutter build ios --release
install-custom-flavors: ## Run the base command for flutter_flavorizr. Be careful: IT WILL OVERRIDE SOME FILES
	fvm flutter pub run flutter_flavorizr -p assets:download,assets:extract,android:androidManifest,android:buildGradle,android:dummyAssets,flutter:flavors,ios:xcconfig,ios:buildTargets,ios:schema,ios:dummyAssets,ios:plist,ios:launchScreen,assets:clean,ide:config
	sed -i.bak '/class F {/,$d' lib/flavors.dart
	rm lib/flavors.dart.bak
buildAndInstall:
	make build-apk
	
	adb install -r ./build/app/outputs/flutter-apk/app-release.apk
clean-pods: ## Build an APK of any app with flavor name. e.g. make build base
	cd ios/
	rm -rf Pods
	rm -rf Podfile.lock
	rm -rf Podfile
	rm -rf Runner.xcworkspace
	cd ../
	fvm flutter clean
	fvm flutter pub get

###
# Dependencies section
###
dependencies: ## Install all dependencies

	fvm flutter pub get


###
# Tests section
###
test: ## Run all tests
	fvm flutter test