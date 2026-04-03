import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIContext } from 'astro';

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
      link: `/links/${post.slug}/`,
    })),
    customData: '<language>en-us</language>',
  });
}
