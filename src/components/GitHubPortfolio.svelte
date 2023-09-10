<script lang="ts">
  import RepoCard from "../components/RepoCard.svelte";
  import { flip } from "svelte/animate";
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
</style>
