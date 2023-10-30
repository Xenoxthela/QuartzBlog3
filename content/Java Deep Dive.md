---
title: Java Deep Dive
draft: false
tags:
  - example-tag
  - publish
---
 

Buch Empfehlung:

Effective Java - Joshua Bloch - 978-3-86490-578-0


##### Konstruktor Null-Sicher gestalten
```java
public Employee(String firstname, String lastname) {

this.firstname = Objects.requireNonNull(firstname);
this.lastname = Objects.requireNonNull(lastname);
}
```

