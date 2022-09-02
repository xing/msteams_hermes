# MsTeamsHermes

Like Hermes, the messenger of the greek gods, this gem helps you sending messages to your Microsoft Teams channels. With autonomy to create your own layouts, like UI kits such as React, Flutter, SwiftUI (and some others), you will be able to customize it with the objects representations of [Microsoft's adaptive cards](https://adaptivecards.io/explorer/). 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'msteams_hermes'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install msteams_hermes

## Usage

First of all, you need a Webhook URL, which is responsible to identify which channel should receive the messages we are about to send. To generate one, follow [Microsoft's instructions](https://docs.microsoft.com/en-us/microsoftteams/platform/webhooks-and-connectors/how-to/add-incoming-webhook).

### Your first message

A default _Hello World!_ message could be sent by simply:

```ruby
require "msteams_hermes/components/adaptive_card"
require "msteams_hermes/components/text_block"
require "msteams_hermes/message"

content = MsTeamsHermes::Components::AdaptiveCard.new(
  body: [
    MsTeamsHermes::Components::TextBlock.new(
      text: "Hello World!",
    )
  ]
)

MsTeamsHermes::Message.new(webhook_url: <YOUR_WEBHOOK_URL>, content: content).deliver
```

- You can provide the `webhook_url` by either sending it as a param or setting it as an environment variable, but it must not be nil.
- `content` must always be an `AdaptiveCard`, which is the top component for Microsoft's webhook messages.

Each component, each style, each action is a 1:1 representation from [Microsoft's adaptive cards](https://adaptivecards.io/explorer/).

If you want a more elaborated example on how to create message with complex layouts, check out this [example](https://github.com/[USERNAME]/msteams_hermes/blob/main/complex_example.rb).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/msteams_hermes. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/msteams_hermes/blob/main/CODE_OF_CONDUCT.md).

### Adding new components, styles and actions

Every new component, style or action must implement the `to_hash` method, which serializes the object into a hash object to be sent to the `webhook_url`. When implementing the `to_hash` method, pay attention to the JSON structure of the given object, usually described on the _Example_ section of its documentation on [adaptivecards.io](https://adaptivecards.io/explorer/).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MsteamsHermes project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/msteams_hermes/blob/main/CODE_OF_CONDUCT.md).
