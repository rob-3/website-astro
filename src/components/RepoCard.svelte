<script lang="ts">
	import type { GitHubRepositoryData } from "../components/GitHubRepositoryData";
	import { fade } from "svelte/transition";
	import { colors } from "../consts";
	import { onMount } from "svelte";
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

	let ref: HTMLDivElement;
	/*
	onMount(() => {
		document.addEventListener("mousemove", event => {
			const { clientX, clientY } = event;
			const { left, right, top, bottom } = ref.getBoundingClientRect();
			const x = (left + right) / 2;
			const y = (top + bottom) / 2;
			const scale = 50;
			if (clientX - x > 0) {
				if (clientY - y > 0) {
					ref.style.boxShadow = `-${(clientX - x) / scale}px -${(clientY - y) / 100}px 10px -2px rgb(71 85 105)`;
				} else {
					ref.style.boxShadow = `-${(clientX - x) / scale}px ${(
						y - clientY
					) / scale}px 10px -2px rgb(71 85 105)`;
				}
			} else {
				if (clientY - y > 0) {
					ref.style.boxShadow = `${(x - clientX) / scale}px -${(clientY - y) / 100}px 10px -2px rgb(71 85 105)`;
				} else {
					ref.style.boxShadow = `${(x - clientX) / scale}px ${(
						y - clientY
					) / scale}px 10px -3px rgb(71 85 105)`;
				}
			}
		});
	});
	*/
</script>

<a href={html_url} class="no-underline">
<div
	bind:this={ref}
	in:fade
	class="group no-underline drop-shadow-lg flex flex-col h-full p-4 rounded-sm border border-slate-300 bg-slate-100 hover:translate-x-1 hover:translate-y-1 hover:cursor-pointer transition-transform"
>
	<div>
		<svg
			class="inline-block"
			style="fill: #586069;"
			viewBox="0 0 16 16"
			version="1.1"
			width="16"
			height="16"
			aria-hidden="true"
			><path
				fill-rule="evenodd"
				d="M2 2.5A2.5 2.5 0 014.5 0h8.75a.75.75 0 01.75.75v12.5a.75.75 0 01-.75.75h-2.5a.75.75 0 110-1.5h1.75v-2h-8a1 1 0 00-.714 1.7.75.75 0 01-1.072 1.05A2.495 2.495 0 012 11.5v-9zm10.5-1V9h-8c-.356 0-.694.074-1 .208V2.5a1 1 0 011-1h8zM5 12.25v3.25a.25.25 0 00.4.2l1.45-1.087a.25.25 0 01.3 0L8.6 15.7a.25.25 0 00.4-.2v-3.25a.25.25 0 00-.25-.25h-3.5a.25.25 0 00-.25.25z"
			/></svg
		>
		<span class="text-blue-700 font-medium group-hover:underline">{name}</span>
	</div>
	{#if fork}
		<div class="text-xs text-[#586069]">
			Forked from <a class="text-blue-700 hover:underline" href={source.html_url}>{source.full_name}</a>
		</div>
	{/if}
	<div class="my-2 text-xs text-[#586069]">
		{description || "No description, website, or topics provided."}
	</div>
	<div
		style="font-size: 12px; color: #586069;"
		class="mt-auto flex items-center gap-2"
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
</a>
