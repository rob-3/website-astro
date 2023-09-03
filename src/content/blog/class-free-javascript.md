---
title: "Class-Free JavaScript"
description: "Lorem ipsum dolor sit amet"
pubDate: "Apr 2 2023 17:00"
---

I often get incredulous looks from people when I tell them that I don't use the
`class` keyword in my JavaScript. Especially in an age of object-oriented
programming, the class seems like a fundamental construct. Is it really
possible to avoid `class` entirely? And if so, why bother?

The answer to the first question is "yes". The purpose of a class is to
construct objects that can bundle data and associated functions. We can
construct objects in JavaScript directly by using an object
literal:

```js
// Look ma, no `class`!
const elephant = {
  name: "Elliot",
  age: 5,
};
elephant.name; // "Elliot"
elephant.age; // 5
```

<aside>
If you're not familiar with JavaScript object literals, think of them like
a hash map, dictionary, or table in your favorite language. Object literals are
a collection of key:value pairs.
</aside>

But how can we add a function to our object? One way is to use an anonymous function:

```js
const elephant = {
  name: "Elliot",
  age: 5,
  sayHello: function () {
    console.log(`${this.name}: <deafening trumpet>`);
  },
};
elephant.sayHello(); // "Elliot: <deafening trumpet>"
```

But this syntax has been largely replaced with the more concise "method
shorthand" that has the same meaning.[^on-methods]

```js
const elephant = {
  name: "Elliot",
  age: 5,
  sayHello() {
    console.log(`${this.name}: <deafening trumpet>`);
  },
};
elephant.sayHello(); // "Elliot: <deafening trumpet>"
```

<aside>
We can't use an arrow function <code>() => {}</code> here, because arrow
functions maintain the <code>this</code> value of the enclosing context (which
is not the object). There are cases where this behavior is useful, but never
for member functions.
</aside>

Now, this technique is fine for one-off config objects and similar cases, but
it gets old quickly when you need to create a bunch of objects.

```js
const elephant = {
  name: "Elliot",
  age: 5,
  sayHello() {
    console.log(`${this.name}: <deafening trumpet>`);
  },
};
const elephant2 = {
  name: "Esteban",
  age: 2,
  sayHello() {
    console.log(`${this.name}: <deafening trumpet>`);
  },
};
```

Usually, this situation is when people reach for a `class`. For just fields,
object literals aren't bad, but add a few functions, and it quickly gets old.

There are two ways around using a class here. People often overlook simply
freeing the function from the object.

```js
const sayHello = (elephant) => {
  console.log(`${elephant.name}: <deafening trumpet>`);
};
const elephant = {
  name: "Elliot",
  age: 5,
};
const elephant2 = {
  name: "Esteban",
  age: 2,
};
sayHello(elephant);
sayHello(elephant2);
```

Some might denigrate such an approach as "procedural" or "C-style programming",
but there's really nothing wrong with a regular function. Regular functions are
easy to read, easy to write, and don't have polymorphism, inheritance, or
tricky behavior around `this`. This code also always has the best performance
across JavaScript engines.[^dynamic-dispatch]

The other approach is to simply write a function which builds and returns the
object.

```js
const Elephant = (name, age) => ({
  name,
  age,
  sayHello() {
    console.log(`${this.name}: <deafening trumpet>`);
  },
});
const elephant = Elephant("Elliot", 5);
const elephant2 = Elephant("Esteban", 2);
elephant.sayHello();
elephant2.sayHello();
```

<aside>
A few notes on syntax:

You might be wondering why we aren't using <code>name: name</code> and
<code>age: age</code> in the code above. JavaScript allows you to omit the
variable name if it is the same as the key name.

Also, we have to wrap the object literal in parentheses to avoid it being
parsed as a block of code. You can also include a block of code and use
a <code>return</code> statement; this is useful if you need to do some
computation before you can construct the object or if you need to conditionally
construct different objects. For basic cases, the above is the most concise
approach.

</aside>

One advantage of this approach is that it plays better with completions in most
editors, which like to look up member functions when you type `.`.

One downside is that it allocates memory for a new instance of `sayHello()` for
every `Elephant`, since they aren't shared. I did some unscientific
benchmarking[^benchmarking] and I found that this can have a significant
performance penalty if you're creating large numbers of objects.

For that reason, I recommend doing the following for any objects you will be
making 100+ copies of:

```js
function sayHello() {
  console.log(`${this.name}: <deafening trumpet>`);
}
const Elephant = (name, age) => ({
  name,
  age,
  sayHello,
});
```

This gives equivalent performance to a class in Chrome and Safari, and better
performance than an equivalent class in Firefox (at least on my machine).

<aside>
Remember to use the <code>function</code> keyword if you need <code>this</code>
to be scoped to the object.
</aside>

I find that these two patterns cover the majority of cases. Usually, you just
need to have some data, and some operations on that data.

## But I need polymorphism!

You can easily achieve dynamic polymorphism by constructing similar objects
with different functions.

```js
const Elephant = (name, age) => ({
  name,
  age,
  sayHello() {
    console.log(`${this.name}: <deafening trumpet>`);
  },
});
const Chicken = (name, age) => ({
  name,
  age,
  sayHello() {
    console.log(`${this.name}: bawk!`);
  },
});
```

You can also consider using a type field and pursuing a pattern matching
approach:

```js
const Elephant = (name, age) => ({
  type: "elephant",
  name,
  age,
});
const Chicken = (name, age) => ({
  type: "chicken",
  name,
  age,
});
const sayHello = (animal) => {
  switch (animal.type) {
    case "chicken":
      console.log(`${this.name}: bawk!`);
      break;
    case "elephant":
      console.log(`${this.name}: <deafening trumpet>`);
      break;
    default:
      throw Error(`sayHello() not implemented for type ${animal.type}`);
  }
};
```

The trade-off between these designs deserves a post of its own, but more and
more I find myself reaching for this second approach. It is better for
[serialization](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/JSON/stringify)
because the type of the data lives in a field instead of hidden in dynamic dispatch.
If you leave functions out of your data you can also do a
[deep copy](https://developer.mozilla.org/en-US/docs/Web/API/structuredClone)
more easily.

## But I need inheritance!

You don't.

I don't use inheritance. I tried to come up with a simple example where I would
use inheritance, but I couldn't. There probably are real-world situations where
inheritance is the right choice, but I contend there are far more real-world
situations where inheritance is abused and misused, and provides ambiguous or
negative value.

Avoiding inheritance is one reason I like to write JavaScript without classes.
You can, of course, avoid inheritance problems with classes, either by being
smart or just never using `extends`. But I often find that the temptation to
use inheritance just isn't worth it. More options aren't always better;
a trap is worse than no option.[^inheritance]

## But I need encapsulation!

While there are now [private fields](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Classes/Private_class_fields)
in JavaScript, [only 68% of developers even know about them, and less than half
of _those_ developers use them](https://2022.stateofjs.com/en-US/features/). If
you don't have a specific use case, I don't think you need them.

The benefits of encapsulation are generally overstated, but on the other hand,
the downsides are often ignored:

1. More difficult to `console.log()` since they are only accessible from the class.
2. More difficult to persist or send over the network because
   `JSON.stringify()` doesn't pick them up.

Because private fields try to be invisible to other code, they're harder to
work with in other code. In rare cases, this might be what you want, but more
often than not, I believe public fields are more useful and easier to debug.

## But why?

> Perfection is achieved, not when there is nothing more to add, but when there
> is nothing left to take away.
>
> ― Antoine de Saint-Exupéry, Airman's Odyssey

Class-free JavaScript is less capable than a `class`. Everything I've
mentioned above can be achieved in a `class`, with perhaps slightly more
code. _That's not a bug -- that's a feature._

I'm not against classes. I'm against their misuse. By defaulting to not using
a `class`, I force myself to write simpler and better code. I've written
several significant projects without a single `class` keyword, and I like how
they've informed the way I write code.

Try your next project without `class`, and see if you don't enjoy
a data-focused, inheritance-free experience.

[^on-methods]:
    The use of the word "method" has always been a frustrating subtlety to me.
    It is typically intended to clarify whether a function is a member of
    a class; in practice, however, this distinction is often lost or not
    useful. In Java, for example, every function must live in some class, so
    does Java only have methods? Lua has calling syntax that allows you to
    effectively treat a function like a method. Should the name change based on
    the syntax used? Most software engineers seem to use them interchangeably,
    so I try to prefer function as the more universal and easily-understood
    term.

[^dynamic-dispatch]:
    I suspect this is due to dynamic dispatch. Dynamic dispatch is how
    JavaScript and other languages implement class polymorphism - the ability
    of different objects to have different behavior on a method call. In
    a free function, there is always one path of code execution. Method calls,
    however, could dispatch to different blocks of code based on the class
    type. If you don't actually need this, you may be paying a performance
    penalty. On my machine, V8 (Chrome) and JSC (Safari) seem to be able to
    optimize the dispatch to have negligible overhead in simple cases, but
    in SpiderMonkey (Firefox), the free function is the best performer.

[^benchmarking]: https://jsbench.me/telfizii6g
[^inheritance]:
    That being said, there is a concise way to achieve inheritance-like
    behavior without classes, which I'll leave as an exercise to the reader :)
