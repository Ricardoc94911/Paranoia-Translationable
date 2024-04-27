# Paranoia-Translationable
This is a helper that allows the user to take advantage of the Paranoia Gem while also using the globalize gem


## The Problem
I basically wanted to implement Paranoia usage on an application that also used translations from [Globalize Gem](https://github.com/globalize/globalize)
The problem was that when using the `translates` helper on a model, it ended up causing some conflicts with the [Paranoia Gem](https://github.com/rubysherpas/paranoia) where it would **hard delete** translation records instead of **soft deleting** them.
So that's when i ended up creating this helper.

## Usage
To use this helper you just need to include it into your models that also use `acts_as_paranoid` from the Paranoia Gem and instead of using `translates` from the Globalize Gem, like you normally do, you instead do something like this:

```
class YourModel
  include ParanoiaTranslationable

  acts_as_paranoid
  paranoia_translates :name
end
```

I also made it possible to customise the relationship through which you access your translations. So in situations like this one:

```
class YourModel
  include ParanoiaTranslationable

  acts_as_paranoid
  paranoia_translates :name

  has_many :custom_translation_relation, dependent: :destroy
end
```

You'd have a problem because this helper uses naming conventions by default, aka, it'll assume that there's a model relation called `your_model_translations` which, in this particular case, there isn't.
Given that you'd have to use the following syntax:

```
class YourModel
  include ParanoiaTranslationable

  acts_as_paranoid
  paranoia_translates :name, relation_name: :custom_translation_relation

  has_many :custom_translation_relation, dependent: :destroy
end
```
