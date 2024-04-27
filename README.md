# Paranoia-Translationable
This is a helper that allows the user to take advantage of the Paranoia Gem while also using the globalize gem


##The Problem
I basically wanted to implement Paranoia usage on an application that also used translations from [Globalize Gem](https://github.com/globalize/globalize)
The problem was that when using the `translates` helper on a model, it ended up causing some conflicts with the [Paranoia Gem](https://github.com/rubysherpas/paranoia) where it would **hard delete** translation records instead of **soft deleting** them.
So that's when i ended up creating this helper.

##Usage
To use this helper you just need to include it into your models that also use `acts_as_paranoid` from the Paranoia Gem and instead of using `translates` from the Globalize Gem, like you normally do, you instead do something like this:

```
class YourModel
  include ParanoiaTranslationable

  acts_as_paranoid
  paranoia_translates :name
end
```
