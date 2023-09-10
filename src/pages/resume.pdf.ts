import type { APIRoute } from "astro";

export const GET: APIRoute = async () => {
  const resumeResponse = await fetch(
    "https://api.github.com/repos/rob-3/resume/contents/resume.pdf",
    {
      headers: {
        Accept: "application/vnd.github.raw",
        Authorization: `Bearer ${import.meta.env.GITHUB_API_TOKEN}`,
        "X-GitHub-Api-Version": "2022-11-28",
      },
    },
  );
  const resumePdf = Buffer.from(await resumeResponse.arrayBuffer()).toString(
    "binary",
  );
  return {
    body: resumePdf,
    encoding: "binary",
  };
};
