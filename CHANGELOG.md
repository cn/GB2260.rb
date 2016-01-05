# GB2260.rb Change Log

All notable changes to this project will be documented in this file.

GB2260.rb is in a pre-1.0 state. This means that its APIs and behavior are subject to breaking changes without deprecation notices. Until 1.0, version numbers will follow a [Semver][]-ish `0.y.z` format, where `y` is incremented when new features or breaking changes are introduced, and `z` is incremented for lesser changes or bug fixes.

## [Unreleased]

Your contribution here!

## 0.2.1 (2016-01-05)

* Return nil when the division is inexistent (https://github.com/cn/GB2260.rb/pull/4)
* Improve child divisions query performance (https://github.com/cn/GB2260.rb/pull/8)
* Add `#description` method to return human readable description (https://github.com/cn/GB2260.rb/pull/7)

## 0.2.0 (2015-11-11)

* Implement spec 0.2 (https://github.com/cn/GB2260/blob/v0.2/spec.md)
* Deprecate `#year` of `Division`

## 0.1.1 (2015-09-12)

* Fix description on rubygems

## 0.1.0 (2015-09-12)

* Initial release

[Semver]: http://semver.org
[Unreleased]: https://github.com/cn/GB2260.rb/compare/v0.2.1...HEAD
