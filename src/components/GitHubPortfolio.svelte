<script lang="ts">
  import RepoCard from "../components/RepoCard.svelte";
  import { flip } from "svelte/animate";
  import { fade } from "svelte/transition";
  import type { GitHubRepositoryData } from "../components/GitHubRepositoryData";

  export let repos: GitHubRepositoryData[] = [];
  let myRepos = repos;
</script>

<div class="cards">
  {#each myRepos as repo (repo.description)}
    <div animate:flip={{ duration: 500 }} class="card">
      <RepoCard {repo} />
    </div>
  {/each}
</div>
{#if myRepos.length === 1}
  <div in:fade class="description">{@html myRepos[0].description}</div>
{/if}

<style>
  .card {
    width: 20em;
    font-size: 0.875em;
    height: 9.043em;
  }
  .cards {
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    gap: 20px;
    font-size: 1rem;
  }
  .description {
    width: min(25em, 100%);
    background-color: white;
    border: 1px solid #e1e4e8;
    box-sizing: border-box;
    box-shadow:
      0 0.25em 0.5em 0 rgba(0, 0, 0, 0.2),
      0 0.375em 1.25em 0 rgba(0, 0, 0, 0.19);
    border-radius: 0.375em;
    padding: 1.2em;
  }
</style>
