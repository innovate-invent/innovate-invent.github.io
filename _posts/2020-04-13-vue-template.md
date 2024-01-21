---
title: "Vue2 Typescript Jetbrains Template"
excerpt: "A handy file template for Vue single file components"
tags: [vue, typescript, single file component class, vue-property-decorator, decorator, template, webstorm, jetbrains]
---

Over the years I have tried a variety of IDEs and I have found that [Jetbrains](https://www.jetbrains.com/) produces a suite of 
software that fits my needs beautifully.

Vue is a web framework I have recently been working with for various web applications. It is highly modular and supports
TypeScript. [Jetbrains Webstorm](https://www.jetbrains.com/webstorm/) does not include a template for creating 
[Vue Single File Components](https://vuejs.org/v2/guide/single-file-components.html) using [class components](https://vuejs.org/v2/guide/typescript.html#Class-Style-Vue-Components) and TypeScript.

Here is a template created to include these features:  

```html
<template>
#[[$END$]]#
</template>

<script lang="ts">
import { Component, Prop, Watch, Vue } from 'vue-property-decorator';

@Component({ components: {} })
export default class ${COMPONENT_NAME} extends Vue {
\$refs!: {};

}
</script>

<style scoped>

</style>
```

It includes the [Prop](https://github.com/kaorun343/vue-property-decorator#Prop) and [Watch](https://github.com/kaorun343/vue-property-decorator#Watch) decorators from the [vue-property-decorator](https://github.com/kaorun343/vue-property-decorator) package.

`$refs!: {}` is included to declare the type of any [refs](https://vuejs.org/v2/api/#ref) that appear in the template.

If you prefer scss or any preprocessed css then you may be interested in adding to the end:
```html
<style scoped lang="scss">

</style>
``` 

To add it to your Webstorm instance see [the official documentation](https://www.jetbrains.com/help/webstorm/using-file-and-code-templates.html).
