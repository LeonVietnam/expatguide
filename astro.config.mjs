// @ts-check
import { defineConfig } from 'astro/config';
import starlight from '@astrojs/starlight';

export default defineConfig({
	site: 'https://expatguide.site',
	integrations: [
		starlight({
			title: 'ExpatGuide Vietnam',
			lastUpdated: true,
			social: [],
			sidebar: [
				{
					label: 'Visa',
					autogenerate: { directory: 'vietnam/visa' },
				},
				{
					label: 'Housing',
					autogenerate: { directory: 'vietnam/housing' },
				},
				{
					label: 'Banking',
					autogenerate: { directory: 'vietnam/banking' },
				},
				{
					label: 'Daily Life',
					autogenerate: { directory: 'vietnam/daily-life' },
				},
				{
					label: 'Healthcare',
					autogenerate: { directory: 'vietnam/healthcare' },
				},
				{
					label: 'Digital Nomad',
					autogenerate: { directory: 'vietnam/digital-nomad' },
				},
			],
		}),
	],
});
