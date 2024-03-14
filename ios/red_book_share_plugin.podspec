#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint red_book_share_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'red_book_share_plugin'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  s.vendored_frameworks = 'frameworks/*.framework'
  s.resource = 'frameworks/*.*'
  s.libraries = 'stdc++'
  s.resources = 'Assets/*.*'

  s.static_framework = true
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = {
      'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
      'CLANG_CXX_LANGUAGE_STANDARD' => 'compiler-default',
      'CLANG_CXX_LIBRARY' => 'libc++',
      'OTHER_LDFLAGS' => '$(inherited) -ObjC'
  }
end
