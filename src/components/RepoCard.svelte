<script lang="ts">
	import type { GitHubRepositoryData } from "../components/GitHubRepositoryData";
	import { fade } from "svelte/transition";
	import { colors } from "../consts";
	export let repo: GitHubRepositoryData;
	$: ({
		fork,
		forks,
		html_url,
		name,
		source,
		description,
		language,
		stargazers_count,
	} = repo);
</script>

<div in:fade>
	<a href={html_url}>{name}</a>
	{#if fork}
		<div class="text-xs text-[#586069]">
			Forked from <a href={source.html_url}>{source.full_name}</a>
		</div>
	{/if}
	<div class="my-2 text-xs text-[#586069]">
		{description || "No description, website, or topics provided."}
	</div>
	<div
		style="font-size: 12px; color: #586069;"
		class="flex items-center gap-2"
	>
		{#if language}
			<span class="flex items-center gap-1">
				<span
					class="w-3 h-3 rounded-full"
					style={`background-color: ${
						language ? colors[language].color : ""
					};`}
				/>
				<span>{language}</span>
			</span>
		{/if}
		{#if stargazers_count !== 0}
			<span class="flex items-center gap-1">
				<svg
					style="fill: #586069;"
					aria-label="stars"
					viewBox="0 0 16 16"
					version="1.1"
					width="16"
					height="16"
					role="img"
					><path
						fill-rule="evenodd"
						d="M8 .25a.75.75 0 01.673.418l1.882 3.815 4.21.612a.75.75 0 01.416 1.279l-3.046 2.97.719 4.192a.75.75 0 01-1.088.791L8 12.347l-3.766 1.98a.75.75 0 01-1.088-.79l.72-4.194L.818 6.374a.75.75 0 01.416-1.28l4.21-.611L7.327.668A.75.75 0 018 .25zm0 2.445L6.615 5.5a.75.75 0 01-.564.41l-3.097.45 2.24 2.184a.75.75 0 01.216.664l-.528 3.084 2.769-1.456a.75.75 0 01.698 0l2.77 1.456-.53-3.084a.75.75 0 01.216-.664l2.24-2.183-3.096-.45a.75.75 0 01-.564-.41L8 2.694v.001z"
					/></svg
				>
				<span>{stargazers_count}</span></span
			>
		{/if}
		{#if forks !== 0}
			<span class="flex items-center gap-1">
				<svg
					style="fill: #586069;"
					aria-label="fork"
					viewBox="0 0 16 16"
					version="1.1"
					width="16"
					height="16"
					role="img"
					><path
						fill-rule="evenodd"
						d="M5 3.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm0 2.122a2.25 2.25 0 10-1.5 0v.878A2.25 2.25 0 005.75 8.5h1.5v2.128a2.251 2.251 0 101.5 0V8.5h1.5a2.25 2.25 0 002.25-2.25v-.878a2.25 2.25 0 10-1.5 0v.878a.75.75 0 01-.75.75h-4.5A.75.75 0 015 6.25v-.878zm3.75 7.378a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm3-8.75a.75.75 0 100-1.5.75.75 0 000 1.5z"
					/></svg
				>
				<span>{forks}</span>
			</span>
		{/if}
	</div>
</div>

<style>
	a:hover {
		text-decoration: underline;
	}
</style>
