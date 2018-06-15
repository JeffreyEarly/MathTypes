MathTypes
===========

Swift current lacks numeric types appropriate for scientific programming. This document provides an overview of the design requirements for scientific programming, as well as one possible implementation.

Design Requirements
===================

This set of design requirements arose out of earlier discussions on the Swift forums, as well as existing practices used by the scientific community with Python, Matlab, and Julia. There may be other requirements, and, if so, please discuss.

## 1. Do not interfere with the existing behavior of Standard Library types

As raised in both this context and in this context, there is very strong resistance to changing the behavior of the existing types in the Swift Standard Library.

## 2. Sensible mixed precision promotion and demotion rules

There are a number of choices that have to be made with regards to how Swift handles binary operations with mixed precision types. The types in the Swift Standard Library (such as Int and Float) are closed under all operations, which is not the expected behavior in scientific programming (but may be in other contexts, hence design requirement #1).

1. An integer divided by an integer should go to a floating point type. This was raised in the Swift forums here, and it is clear it must be implemented in some form to create a viable scientific programming environment. One could also consider introducing a rational type.
2. Mixed floating point precision operations should represent the result with the *lowest* precision type. For example, a single plus a double should result in a single. There are really three possible choices here: 1) throw an error, 2) promote to the higher precision type (like Julia) or 3) demote to the lower precision type (like Matlab). Option 2 is obviously wrong, since you've now introduced garbage into the value type. Option 1 is dangerous, because although it forces the programmer to make a decision, it will rarely be the case that promoting the single precision to a double precision is the right thing to do. Thus, it makes the most sense to automatically demote precision.

## 3. Avoid unnecessary algebriac type promotion

As discussed in the Swift forums and summarized here, one should avoid unnecessary floating point operations and memory requirements when possible. For example, this means avoiding situations where you need to cast a real number as a complex number in order to multiply by an imaginary number. This loses type information, requires more memory, and requires more floating point operations.

Another useful example of unnecessary type promotion is taking the square root of a real number. Because the real number might be negative or positive, in general you have to assume the result is a complex number. However, if you are able to identify the real number as being either positive or negative, you know the result will be either a positive real or an imaginary number.

## 4. Work well with existing libraries

As much as possible, Swift Math types should try to work well with existing math types in other programming environments. This means embrancing floating point math, but also working with standard complex number data structures.

Implementation
===================

In order to address design requirement #1, this math type library does not define any operations on existing Swift Standard library types. The MathTypes library uses ```Int```, ```Float```, ```Double```, etc only as a *storage* for a new set of types. This allows the implementation of design requirement #2 (mixed precision operations) without interfering with any existing Swift code.

![Type hierarchy](Documentation/NumberHierarchy.png)

Because Swift is statically typed, avoiding unnecessary algebriac type promotion in Swift *requires* encoding the algebriac structure of the different types.
