# OkCupid

> An OkCupid API and CLI written in Ruby

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem 'okcupid'
```

And then execute:

```bash
bundle
```

Or install it yourself:

```bash
gem install okcupid
```

## Usage

### Ruby

#### Require It

```ruby
require 'okcupid'
```

#### API

```ruby
api = OkCupid::API.new(username, password)
```

##### Getting Messages

```ruby
page_one_messages = api.messages
page_two_messages = api.messages(page_one_messages.length + 1)
```

##### Getting an Entire Thread of Messages


```ruby
threadid = api.messages.first.threadid
messages = api.thread(threadid)
```

###### `threadid`

The ID of an OkCupid messaage thread.

##### Deleting an Entire Thread of Messages

```ruby
threadid = api.messages.first.threadid
api.delete_thread(threadid)
```
