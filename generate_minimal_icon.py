#!/usr/bin/env python3
"""
Generate modern minimal app icons for RoastMe Study Buddy
Sleek dark theme with indigo/violet gradient
"""

from PIL import Image, ImageDraw
import os

def create_modern_minimal_icon(size):
    """Create a sleek modern minimal icon with dark theme"""
    # Create image with deep dark background
    img = Image.new('RGB', (size, size), '#0F0F1E')
    draw = ImageDraw.Draw(img)
    
    # Calculate dimensions
    center = size // 2
    
    # Draw gradient background circle (subtle)
    gradient_size = int(size * 0.85)
    
    # Create a radial gradient effect with indigo to violet
    for i in range(100):
        radius = gradient_size // 2 - (i * gradient_size // 200)
        if radius <= 0:
            break
        
        # Interpolate between indigo (#6366F1) and violet (#8B5CF6)
        r = int(99 + (139 - 99) * (i / 100))
        g = int(102 + (92 - 102) * (i / 100))
        b = int(241 + (246 - 241) * (i / 100))
        
        color = (r, g, b)
        draw.ellipse(
            [center - radius, center - radius, center + radius, center + radius],
            fill=color,
            outline=None
        )
    
    # Draw minimal flame icon in the center (geometric design)
    flame_scale = size * 0.4
    
    # Main flame body (teardrop/droplet shape)
    flame_points = [
        (center, center - flame_scale * 0.5),  # Top point
        (center + flame_scale * 0.35, center + flame_scale * 0.3),  # Right curve
        (center, center + flame_scale * 0.5),  # Bottom point
        (center - flame_scale * 0.35, center + flame_scale * 0.3),  # Left curve
    ]
    
    # Draw outer flame (white)
    draw.polygon(flame_points, fill='#FFFFFF', outline=None)
    
    # Draw inner flame accent (warm yellow-white)
    inner_scale = 0.6
    inner_points = [
        (center, center - flame_scale * 0.5 * inner_scale),
        (center + flame_scale * 0.25 * inner_scale, center + flame_scale * 0.2),
        (center, center + flame_scale * 0.4),
        (center - flame_scale * 0.25 * inner_scale, center + flame_scale * 0.2),
    ]
    draw.polygon(inner_points, fill='#FEF3C7', outline=None)
    
    # Add subtle border for definition
    border_width = max(2, size // 100)
    draw.ellipse(
        [border_width, border_width, size - border_width, size - border_width],
        outline='#25253A',
        width=border_width
    )
    
    return img

def main():
    # Icon sizes for iOS
    sizes = {
        'icon_1024.png': 1024,
        'icon_180.png': 180,
        'icon_167.png': 167,
        'icon_152.png': 152,
        'icon_120.png': 120,
        'icon_87.png': 87,
        'icon_80.png': 80,
        'icon_76.png': 76,
        'icon_60.png': 60,
        'icon_58.png': 58,
        'icon_40.png': 40,
        'icon_29.png': 29,
    }
    
    output_dir = 'RoastMeStudyBuddy/Assets.xcassets/AppIcon.appiconset'
    
    if not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    print("🎨 Generating modern minimal app icons with dark theme...")
    
    for filename, size in sizes.items():
        print(f"  Creating {filename} ({size}x{size})")
        icon = create_modern_minimal_icon(size)
        icon.save(os.path.join(output_dir, filename), 'PNG')
    
    print("✅ All icons generated successfully!")
    print(f"📁 Saved to: {output_dir}")
    print("🎯 Theme: Sleek dark with indigo/violet gradient and minimal white flame")

if __name__ == '__main__':
    main()
