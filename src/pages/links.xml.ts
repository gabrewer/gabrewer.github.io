import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIContext } from 'astro';

function getSlug(post: { id: string; data: { slug?: string } }) {
  return post.data.slug || post.id.replace(/\.mdx?$/, '');
}

export async function GET(context: APIContext) {
  const posts = await getCollection('links', ({ data }) => import.meta.env.DEV || !data.draft);

  const sorted = posts.sort(
    (a, b) => b.data.date.getTime() - a.data.date.getTime()
  );

  return rss({
    title: 'Greg Brewer — Useful Links',
    description:
      'Curated links covering AI engineering, software architecture, developer tools, and things worth reading.',
    site: context.site!,
    items: sorted.map((post) => ({
      title: post.data.title,
      pubDate: post.data.date,
      description: `Useful Links — ${post.data.title}`,
      link: `/links/${getSlug(post)}/`,
    })),
    customData: '<language>en-us</language>',
  });
}
