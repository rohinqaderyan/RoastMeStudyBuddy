#!/usr/bin/env python3
"""
Generate a trendy app icon for RoastMe Study Buddy
Theme: Fire emoji + brain/book with gradient background
"""

from PIL import Image, ImageDraw, ImageFont
import os

def create_gradient_background(size, color1, color2):
    """Create a gradient background"""
    base = Image.new('RGB', (size, size), color1)
    draw = ImageDraw.Draw(base)
    
    for i in range(size):
        # Create vertical gradient
        ratio = i / size
        r = int(color1[0] * (1 - ratio) + color2[0] * ratio)
        g = int(color1[1] * (1 - ratio) + color2[1] * ratio)
        b = int(color1[2] * (1 - ratio) + color2[2] * ratio)
        draw.line([(0, i), (size, i)], fill=(r, g, b))
    
    return base

def add_emoji_style_icon(img, size):
    """Add fire and brain emoji-style graphics"""
    draw = ImageDraw.Draw(img)
    
    # Draw a stylized flame shape (bottom to top)
    flame_color_1 = (255, 87, 34)  # Deep orange
    flame_color_2 = (255, 193, 7)  # Amber
    flame_color_3 = (255, 235, 59)  # Yellow
    
    center_x = size // 2
    center_y = int(size * 0.55)
    
    # Main flame body (large teardrop)
    flame_points = [
        (center_x, int(size * 0.75)),  # Bottom
        (int(size * 0.35), int(size * 0.45)),  # Left
        (int(size * 0.40), int(size * 0.30)),  # Top left
        (center_x, int(size * 0.20)),  # Top
        (int(size * 0.60), int(size * 0.30)),  # Top right
        (int(size * 0.65), int(size * 0.45)),  # Right
    ]
    draw.polygon(flame_points, fill=flame_color_1)
    
    # Inner flame (medium)
    inner_flame_points = [
        (center_x, int(size * 0.70)),
        (int(size * 0.40), int(size * 0.48)),
        (center_x, int(size * 0.28)),
        (int(size * 0.60), int(size * 0.48)),
    ]
    draw.polygon(inner_flame_points, fill=flame_color_2)
    
    # Core flame (small)
    core_flame_points = [
        (center_x, int(size * 0.65)),
        (int(size * 0.45), int(size * 0.50)),
        (center_x, int(size * 0.35)),
        (int(size * 0.55), int(size * 0.50)),
    ]
    draw.polygon(core_flame_points, fill=flame_color_3)
    
    # Add book/brain icon at bottom
    book_y = int(size * 0.78)
    book_width = int(size * 0.4)
    book_height = int(size * 0.15)
    book_left = center_x - book_width // 2
    
    # Book base
    draw.rounded_rectangle(
        [book_left, book_y, book_left + book_width, book_y + book_height],
        radius=8,
        fill=(138, 43, 226),  # Purple
        outline=(75, 0, 130),
        width=3
    )
    
    # Book pages line
    draw.line(
        [(center_x, book_y), (center_x, book_y + book_height)],
        fill=(200, 200, 255),
        width=2
    )
    
    return img

def create_app_icon(size, output_path):
    """Create a single app icon of given size"""
    # Gradient from purple to orange
    color1 = (156, 39, 176)  # Purple
    color2 = (233, 30, 99)   # Pink/Red
    
    img = create_gradient_background(size, color1, color2)
    img = add_emoji_style_icon(img, size)
    
    # Round corners for iOS style
    mask = Image.new('L', (size, size), 0)
    mask_draw = ImageDraw.Draw(mask)
    # iOS icon corner radius is approximately 22.37% of the size
    radius = int(size * 0.2237)
    mask_draw.rounded_rectangle([0, 0, size, size], radius=radius, fill=255)
    
    # Apply mask
    output = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    output.paste(img, (0, 0))
    output.putalpha(mask)
    
    # Save
    output.save(output_path, 'PNG')
    print(f"Created: {output_path}")

def main():
    # Create icons for iOS
    base_path = "/Users/QADERA01/iOS App/RoastMeStudyBuddy/RoastMeStudyBuddy/Assets.xcassets/AppIcon.appiconset"
    
    # Standard iOS app icon size
    create_app_icon(1024, os.path.join(base_path, "icon_1024.png"))
    
    # Additional common sizes
    sizes = [180, 167, 152, 120, 87, 80, 76, 60, 58, 40, 29]
    for size in sizes:
        create_app_icon(size, os.path.join(base_path, f"icon_{size}.png"))
    
    print("\n✅ All app icons created successfully!")
    print("📱 Icons are trendy with gradient background and fire+book theme")

if __name__ == "__main__":
    main()
