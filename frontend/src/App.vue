<script setup lang="ts">
import { onMounted, ref } from "vue";
import { checkHealth } from "./health";

const status = ref("Verbindung wird geprüft …");
onMounted(async () => {
  status.value = (await checkHealth())
    ? "Mit Jausi verbunden"
    : "Server gerade nicht erreichbar";
});
</script>

<template>
  <main>
    <header>
      <img src="/favicon.svg" alt="" width="36" height="36" /> Jausi
    </header>
    <section class="hero" aria-labelledby="headline">
      <div>
        <p class="eyebrow">Weniger grübeln. Mehr genießen.</p>
        <h1 id="headline">Was ist da?<br /><span>Was koch ich?</span></h1>
        <p class="intro">
          Dein Vorrat. Deine Rezepte. Eine gute Idee fürs Abendessen.
        </p>
        <p class="status" role="status">{{ status }}</p>
      </div>
      <img
        class="mascot"
        src="/jausi-mascot.png"
        alt="Das Jausi-Möhrchen mit zwei Einkaufstaschen"
      />
    </section>
    <section class="features" aria-label="Das ist geplant">
      <article>
        <span>01</span>
        <h2>Vorrat im Blick</h2>
        <p>Was du daheim hast, an einem Ort.</p>
      </article>
      <article>
        <span>02</span>
        <h2>Rezepte sammeln</h2>
        <p>Deine Lieblingsgerichte griffbereit.</p>
      </article>
      <article>
        <span>03</span>
        <h2>Passendes finden</h2>
        <p>Entdecken, was sich daraus kochen lässt.</p>
      </article>
    </section>
    <footer>
      Technische Vorschau · Semesterprojekt · Die App-Funktionen entstehen noch.
    </footer>
  </main>
</template>
