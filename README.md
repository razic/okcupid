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
messages = api.messages(low, infiniscroll, folder)
```

Returns an array of OkCupid::Message instances.

###### `low`

Default is `1`. Like an index for pagination. Adjust by increments of one to
see a new page of messages.

###### `infiniscroll`

Default is `1`. Not sure what this is used for.

###### `folder`

Default is `1` (received messages). `2` is for sent messages.

##### Getting an Entire Thread of Messages

First you need a message. You can get a hold of one by calling the `messages`
method.

When you have an instance of `OkCupid::Message`, you have access to the
`threadid` to which the message belongs.

You can read an entire thread of messages by querying a thread by its
`threadid`.

```ruby
api.thread(threadid)
```

###### `threadid`

The ID of an OkCupid messaage thread.

##### Deleting an Entire Thread of Messages

```ruby
api.delete_thread(threadid)
```
